# AWS Security Services - Cost Analysis

This document provides a high-level cost overview of the AWS services used in this security project.  
It is meant to demonstrate awareness of the financial impact of security controls while keeping the implementation minimal.

---

## 1. AWS CloudTrail
- **Management Events**: One copy of management events is free per region.
- **Additional Copies / Data Events**: Charged per 100,000 events.
- **S3 Storage**: Logs stored in S3 incur standard S3 storage costs.
- **KMS Encryption**: Additional KMS API requests for encryption/decryption.

---

## 2. Amazon S3 (Central Logging Bucket)
- **Storage**: Billed per GB stored per month.
- **PUT/GET Requests**: Charged per 1,000 requests.
- **Data Transfer**: Free within the same region, costs apply across regions.
- **Public Access Block**: No cost.

---

## 3. AWS KMS (CloudTrail Log Encryption Key)
- **Key Creation**: Free.
- **Key Usage**: $1 per key per month.
- **API Requests**: $0.03 per 10,000 requests (CloudTrail generates these automatically when writing logs).

---

## 4. AWS Config
- **Configuration Items**: $0.003 per item recorded.
- **Rule Evaluations**: $0.001 per evaluation.
- **Configuration Aggregator**: Free.
- **Delivery Channel**: Uses S3 (storage costs apply).
- **KMS**: Optional, if encrypting Config data.

---

# ⚖️ Cost Awareness Summary
This project is intentionally **minimal**:
- Centralized logging (CloudTrail + S3 + KMS) → Essential baseline security.
- Config (recorder + aggregator + rules) → Compliance visibility with small per-item costs.
- Costs are controlled by limiting the scope of events recorded and the number of rules enabled.

👉 In a real-world environment, costs scale with **account activity** (more API calls = more CloudTrail + Config items).
