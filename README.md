# 🛡️ Perp - Enterprise AWS Security & DevOps Showcase

## Overview
A production-grade, multi-account AWS environment demonstrating enterprise security best practices, fully managed via Infrastructure-as-Code (Terraform) and automated DevSecOps pipelines (GitHub Actions).

## 🏗️ Architecture

### Multi-Account Structure
- **Management Account** (783330585630) - AWS Organizations, SCPs, CloudTrail
- **SecOps Account** (993490993886) - Security Hub, GuardDuty, Config, Monitoring
- **Dev Account** (102382809840) - Development workloads and infrastructure
- **Prod Account** - Production patterns (commented out for cost optimization)

### Security-First Design
- **Modular Terraform** - Reusable security modules
- **Compliance Focused** - CIS and AWS Foundational standards
- **Zero-Trust Networking** - IMDSv2, restricted security groups
- **Automated Remediation** - Lambda functions for security violations

---

## 🚀 Features

### 🔒 Security Modules
- **Compliance** - Security Hub with CIS and AWS Foundational standards
- **Detection** - GuardDuty with S3, malware, and runtime monitoring
- **Monitoring** - SNS alerts, EventBridge rules, CloudWatch alarms
- **Logging** - VPC Flow Logs to CloudWatch and S3
- **Remediation** - Automated Lambda functions for S3 and EC2 violations

### 🔧 Infrastructure Modules
- **Compute** - EC2 with SSM, IMDSv2, detailed monitoring
- **Network** - VPC, subnets, security groups, NAT gateways
- **Storage** - S3 with encryption, versioning, lifecycle policies
- **Global** - CloudTrail with SNS notifications

### 🤖 DevSecOps Pipelines
- **Security Validation** - CIS/AWS Foundational compliance scanning
- **Deployment Pipeline** - Multi-account Terraform deployment
- **Drift Detection** - Automated infrastructure drift monitoring
- **OIDC Authentication** - Secure GitHub Actions without stored credentials

---

## 📁 Project Structure

```
Perp/
├── environments/
│   ├── management/          # Management account resources
│   ├── secops/             # Security operations account
│   ├── dev/                # Development account
│   └── prod/               # Production account
├── modules/
│   ├── security/           # Security-focused modules
│   │   ├── compliance/     # Security Hub configuration
│   │   ├── detection/      # GuardDuty setup
│   │   ├── monitoring/     # SNS, EventBridge, CloudWatch
│   │   ├── logging/        # VPC Flow Logs
│   │   └── remediation/    # Lambda remediation functions
│   ├── infrastructure/     # Infrastructure modules
│   │   ├── compute/        # EC2 instances
│   │   ├── network/        # VPC, subnets, security groups
│   │   ├── storage/        # S3 buckets
│   │   └── s3_site/        # Static website hosting
│   ├── iam/               # IAM roles and policies
│   └── global/            # CloudTrail, organization-wide resources
├── policies/              # JSON policy templates
│   ├── iam/              # IAM policies
│   ├── s3-bucket/        # S3 bucket policies
│   ├── scp/              # Service Control Policies
│   └── remediation/      # Lambda remediation policies
├── docs/                 # Comprehensive documentation
│   ├── architecture/     # Architecture diagrams and design
│   ├── compliance/       # Security standards mapping
│   ├── incident-response/ # Security incident procedures
│   └── runbooks/         # Operational procedures
├── scripts/              # Automation and maintenance scripts
│   ├── deployment/       # Deployment utilities
│   ├── maintenance/      # Cleanup and maintenance
│   └── security/         # Security validation tools
└── .github/workflows/     # CI/CD pipelines
    ├── security.yml       # Security validation
    ├── deploy.yml         # Multi-account deployment
    └── drift-detection.yml # Infrastructure drift monitoring
```

---

## 🛠️ Quick Start

### Prerequisites
- AWS CLI configured with appropriate permissions
- Terraform >= 1.5.0
- GitHub repository with OIDC configured

### Deployment
```bash
git clone https://github.com/ailojay/Perp.git
cd Perp

# Deploy management account (SCPs, CloudTrail)
cd environments/management
terraform init
terraform plan
terraform apply

# Deploy SecOps account (Security Hub, GuardDuty)
cd ../secops
terraform init
terraform plan
terraform apply

# Deploy dev account (workloads)
cd ../dev
terraform init
terraform plan
terraform apply
```

---

## 🔍 Security & Compliance

### Compliance Frameworks
- **CIS AWS Foundations Benchmark** - Industry standard security baseline
- **AWS Foundational Security Best Practices** - AWS recommended controls

### Security Controls
- **IMDSv2 Enforcement** - Prevents SSRF attacks on EC2 metadata
- **S3 Security** - Encryption, versioning, access logging, lifecycle policies
- **Network Security** - Restricted security groups, private subnets
- **IAM Security** - Custom break-glass policies, password policies
- **Monitoring** - CloudTrail, VPC Flow Logs, GuardDuty alerts

### Automated Remediation
- **S3 Public Bucket Fixer** - Automatically secures public S3 buckets
- **EC2 Security Group Remediation** - Fixes overly permissive security groups
- **EventBridge Integration** - Real-time security event processing

---

## 🚀 CI/CD Pipelines

### Security Validation Pipeline
- **Triggers**: Every PR and push
- **Scans**: Terraform security best practices (Checkov)
- **Validates**: Syntax, formatting, and security configurations
- **Reports**: Security findings in PR comments

### Deployment Pipeline
- **Triggers**: Push to main branch
- **Stages**: Security validation → Planning → Deployment
- **Environments**: Management → SecOps → Dev
- **Approval**: Manual approval gates for production

### Drift Detection Pipeline
- **Schedule**: Weekdays at 8 AM UTC
- **Monitors**: Infrastructure drift across all accounts
- **Alerts**: GitHub issues for detected changes
- **Reports**: Detailed drift analysis and remediation steps

---

## 🛠️ Development Tools

### Code Quality
- **Pre-commit Hooks** - Terraform formatting, security scanning
- **Terraform Validation** - Syntax and best practices checking
- **Security Scanning** - Built-in security validation in CI/CD

### Operational Scripts
- **Deployment Tools** - Quick status checks and deployment utilities
- **Security Validation** - Automated security foundation testing
- **Maintenance Scripts** - Resource cleanup and drift detection

---

## 🎯 Key Design Decisions

1. **Modular Architecture** - Reusable security and infrastructure modules
2. **Security-First** - CIS compliance and AWS best practices enforced
3. **Multi-Account Strategy** - Isolation and delegation of security services
4. **Automation-Driven** - GitOps workflow with security gates
5. **Compliance-Ready** - Built for enterprise security requirements
6. **Cost-Optimized** - S3 lifecycle policies, efficient resource usage
7. **Monitoring-Enabled** - Comprehensive logging and alerting

---

## 📊 Monitoring & Alerting

- **Security Hub** - Centralized security posture dashboard
- **GuardDuty** - Threat detection and malware scanning
- **CloudTrail** - API call logging with SNS notifications
- **VPC Flow Logs** - Network traffic analysis
- **EventBridge** - Real-time security event processing
- **SNS Alerts** - Security findings notifications

This project demonstrates enterprise-grade AWS security architecture with automated compliance, monitoring, and remediation capabilities.


## PolicyBot (Live SaaS)

A Slack bot that scans Terraform code in real-time using Checkov.

- **Live Demo**: [slack://your-workspace] (after deploy)
- **Features**:
  - `/policy check` → instant findings
  - CIS/AWS FSBP compliant
  - Encrypted logs (S3-KMS)
  - Zero secrets (OIDC + IAM roles)
- **Cost**: ~$50/month
- **Status**: MVP in dev