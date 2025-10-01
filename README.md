# Perp
This is my AWS perp project repo to replicate a working enviroment

# 🛡️ Enterprise AWS Security & DevOps Showcase

## Overview
A production-grade, multi-account AWS environment demonstrating security best practices, fully managed via Infrastructure-as-Code (Terraform) and automated DevSecOps pipelines (GitHub Actions).

## Architecture
![Architecture Diagram](docs/images/architecture-diagram.png)

## Features
- **Secure Foundation**: AWS Organizations with SCPs preventing harmful actions
- **Centralized Security**: GuardDuty, Security Hub, and AWS Config aggregated into dedicated SecOps account
- **DevSecOps Pipeline**: Automated Terraform planning, validation, and security scanning (Checkov, KICS) on every PR
- **GitHub OIDC Integration**: Secure authentication without stored credentials

## Quick Start
```bash
git clone https://github.com/ailojay/Perp.git
cd Perp
terraform -chdir=environments/secops init
terraform -chdir=environments/secops plan









# Perp Cloud Security Project

## Overview

This project showcases a **minimal yet functional AWS SecOps infrastructure**, built with Terraform. The goal is to demonstrate practical Cloud Security skills, focusing on centralized logging, governance, and delegation of security services across accounts.  

The setup covers:

- SecOps account resources  
- Global account policies and Service Control Policies (SCPs)  
- CloudTrail centralized logging  
- AWS Config for compliance monitoring  
- Delegated administration for security services (GuardDuty, Security Hub, Access Analyzer, and Config)  
- IAM roles and permissions for automation via GitHub Actions  

This project is designed to be **concise, clear, and practical**, highlighting an ability to manage cloud security without overcomplicating the environment.

---

## Terraform Components

### 1. SecOps Environment

**Key Resources:**

- **S3 Bucket**: Central logging bucket (`perp-org-logs`)  
  - Blocks public access  
  - Server-side encryption (AES256)  
  - Policy attached via `policies/s3-bucket/cloudtrail_logs.json`  

- **CloudTrail**: Centralized logging across the SecOps account  

- **AWS Config**: Compliance monitoring  
  - Records all supported and global resource types  
  - Delivery channel sends logs to the SecOps bucket  
  - Aggregator configured for organization-wide aggregation  

- **GuardDuty**: Threat detection, with SecOps as the organization admin  

- **Security Hub**: Central security posture monitoring, with SecOps as the organization admin  

- **IAM Roles**:  
  - `config_role` for AWS Config  
  - `secops_role` for GitHub Actions automation  

- **Config Rules**:  
  - `iam-user-mfa-enabled` to ensure all IAM users have MFA  

---

### 2. Global Account

**Key Resources:**

- **Service Control Policies (SCPs)**  
  - Prevent disruptive actions like deleting CloudTrail, stopping Config, or creating unencrypted S3 buckets  

- **Delegated Administrators**  
  - AWS Config  
  - Security Hub  
  - GuardDuty  
  - Access Analyzer  

- **Organization Setup**  
  - Ensures all AWS services are enabled for delegation  

---

### 3. GitHub Actions Workflow

**File**: `.github/workflows/secops.yml`  

**Highlights:**

- Triggered on `push` to `main` affecting `environments/secops/**` or `global/**`  
- Deploys SecOps resources first, then switches to the management/prod account for SCPs and delegation  
- Performs Terraform checks:  
  - `terraform fmt -check`  
  - `terraform validate`  
  - `tflint`  
  - `terraform plan`  
  - `terraform apply`  
- Performs final verification with `terraform plan -lock=false`  

---

### 4. Policies Folder

- All IAM and S3 bucket policies stored in **JSON templates**  
- Keeps Terraform code clean, readable, and modular  

---

## Key Design Decisions

1. **Minimal, functional architecture**  
   - Demonstrates SecOps skills without unnecessary complexity  

2. **Server-side encryption for S3**  
   - Simpler than using KMS keys, easier to maintain  

3. **Delegated administration**  
   - Centralizes management of GuardDuty, Security Hub, AWS Config, and Access Analyzer  

4. **Terraform backend**  
   - Uses S3 with lockfile for state management  

5. **CI/CD Automation**  
   - GitHub Actions workflow handles validation, linting, plan, and apply  

---