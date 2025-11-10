# app/policybot/src/main.py
import os
import json
import logging
from flask import Flask, request, jsonify
import subprocess
import tempfile

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)

def run_checkov(code):
    with tempfile.NamedTemporaryFile("w", suffix=".tf", delete=False) as f:
        f.write(code)
        path = f.name
    try:
        result = subprocess.run(
            ["checkov", "-f", path, "--compact", "-o", "json"],
            capture_output=True, text=True, timeout=30
        )
        logger.info(f"Checkov stdout: {result.stdout}")
        logger.info(f"Checkov stderr: {result.stderr}")

        if not result.stdout.strip():
            return []

        data = json.loads(result.stdout)
        return data.get("results", {}).get("failed_checks", [])
    except Exception as e:
        logger.error(f"Checkov failed: {e}")
        return [{"error": "Scan failed"}]
    finally:
        os.unlink(path)

def format_response(findings):
    if not findings:
        return {"response_type": "in_channel", "text": "No issues found!"}

    blocks = [{"type": "section", "text": {"type": "mrkdwn", "text": "*Security Findings (Top 5)*"}}]
    for f in findings[:5]:
        sev = f.get("severity")
        if sev is None:
            sev = "MEDIUM"
        sev = sev.upper()
        id = f.get("check_id", "?")
        name = f.get("check_name", "?")
        blocks.append({
            "type": "section",
            "text": {"type": "mrkdwn", "text": f"• `{id}` | *{sev}* | {name}"}
        })
    return {"response_type": "in_channel", "blocks": blocks}

@app.route("/slack/events", methods=["POST"])
def slack_events():
    try:
        if request.content_type == "application/x-www-form-urlencoded":
            payload = request.form.get("payload")
            if payload:
                data = json.loads(payload)
                if data.get("type") == "slash_command" and data.get("command") == "/policy":
                    text = data.get("text", "").strip()
                    if text.startswith("check"):
                        code = text[5:].strip()
                        findings = run_checkov(code)
                        return jsonify(format_response(findings))
        return jsonify({"error": "invalid request"}), 400
    except Exception as e:
        logger.error(f"Exception: {str(e)}")
        return jsonify({"error": "internal error"}), 500

@app.route("/health")
def health():
    return jsonify({"status": "healthy"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)