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