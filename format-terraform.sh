#!/bin/bash
# Auto-format all Terraform files before commit
terraform fmt -recursive
git add .