# Opella Azure Infrastructure Automation

## Overview

This repository contains a Terraform-based Azure infrastructure automation solution for Opella.

The solution is designed to demonstrate reusable Infrastructure as Code, environment-based configuration, secure defaults, remote state usage, and a controlled GitHub Actions deployment workflow.

The implementation focuses on simplicity, reusability, security, and maintainability.

---

## Key Highlights

- Reusable Terraform modules for Azure resources
- Single Terraform configuration reused for dev and prod
- Environment-specific values managed using `.tfvars` files
- Separate backend configuration files for dev and prod remote state
- Azure Storage remote backend support
- Manual GitHub Actions workflow
- Dev environment apply through pipeline
- Production apply intentionally disabled
- Private Blob Container
- Public blob access disabled
- HTTPS-only Storage Account
- NSG rules managed through variables
- Clean documentation for architecture, assumptions, release lifecycle, and plan output

---

## Azure Resources Created

This solution provisions the following Azure resources:

- Resource Group
- Virtual Network
- Subnet
- Network Security Group
- Subnet to Network Security Group association
- Storage Account
- Private Blob Container

---

## Repository Structure

```text
opella-devops-terraform-challenge/
├── .github/
│   └── workflows/
│       └── terraform.yml
│
├── documentation/
│   ├── architecture.md
│   ├── assumptions.md
│   ├── release-lifecycle.md
│   └── terraform-plan-output.md
│
├── environments/
│   └── opella/
│       ├── backend.tf
│       ├── backend-dev.hcl
│       ├── backend-prod.hcl
│       ├── main.tf
│       ├── outputs.tf
│       ├── providers.tf
│       ├── variables.tf
│       ├── versions.tf
│       ├── dev.tfvars
│       └── prod.tfvars
│
├── modules/
│   ├── resource_group/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── networking/
│   │   ├── virtual_network/
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   │
│   │   ├── subnet/
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   │
│   │   └── network_security_group/
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   │
│   └── storage_account/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
│
├── .gitignore
└── README.md
```

---

## Module Design

The solution uses separate Terraform modules for each major Azure resource type:

- `resource_group`
- `virtual_network`
- `subnet`
- `network_security_group`
- `storage_account`

Each module has a single responsibility. This makes the code easier to maintain, reuse, test, and extend.

---

## Environment Design

The Terraform environment configuration is placed under:

```text
environments/opella
```

The same `main.tf` is reused for both dev and prod.

Environment-specific values are controlled through:

```text
dev.tfvars
prod.tfvars
```

Remote backend configuration is controlled through:

```text
backend-dev.hcl
backend-prod.hcl
```

This approach avoids code duplication and keeps the deployment process consistent across environments.

---

## Remote Backend

Terraform remote state uses Azure Storage backend.

The `backend.tf` file contains:

```hcl
terraform {
  backend "azurerm" {}
}
```

Dev and prod use separate state keys:

```text
dev.terraform.tfstate
prod.terraform.tfstate
```

The backend Resource Group, Storage Account, and Container must already exist before running `terraform init`.

---

## Security Highlights

Security-focused choices included in this solution:

- No secrets are hardcoded
- Terraform state files are not committed to Git
- Terraform plan files are not committed to Git
- Public blob access is disabled
- Blob container access is private
- HTTPS-only traffic is enabled for Storage Account
- Minimum TLS version is set to TLS 1.2
- Network Security Group rules are controlled through variables
- Dev and prod use separate Terraform state files
- Production apply is not automated

---

## Prerequisites

Install the following tools:

- Terraform >= 1.6.0
- Azure CLI
- Git
- Azure subscription
- GitHub account

Login to Azure:

```bash
az login
az account set --subscription "<subscription-id>"
```

---

## Run Terraform Locally

Go to the Terraform environment folder:

```bash
cd environments/opella
```

### Dev

Initialize Terraform using the dev backend:

```bash
terraform init -backend-config="backend-dev.hcl"
```

Format and validate:

```bash
terraform fmt -recursive
terraform validate
```

Generate dev plan:

```bash
terraform plan -var-file="dev.tfvars" -out="dev.tfplan"
```

Apply dev:

```bash
terraform apply dev.tfplan
```

Generate readable plan output:

```bash
terraform show -no-color dev.tfplan > dev-terraform-plan-output.txt
```

---

### Prod Plan

Initialize Terraform using the prod backend:

```bash
terraform init -reconfigure -backend-config="backend-prod.hcl"
```

Format and validate:

```bash
terraform fmt -recursive
terraform validate
```

Generate prod plan:

```bash
terraform plan -var-file="prod.tfvars" -out="prod.tfplan"
```

Generate readable plan output:

```bash
terraform show -no-color prod.tfplan > prod-terraform-plan-output.txt
```

Production apply is intentionally not automated.

---

## GitHub Actions

The workflow is located at:

```text
.github/workflows/terraform.yml
```

The workflow is manually triggered using `workflow_dispatch`.

It performs:

- Terraform format check
- Terraform init using dev backend
- Terraform validate
- Terraform plan using dev variables
- Upload Terraform plan output
- Terraform apply for dev only

The workflow does not run automatically on push to `main`. This avoids accidental infrastructure changes.

---

## Required GitHub Secrets

Add the following repository secrets:

```text
AZURE_CLIENT_ID
AZURE_CLIENT_SECRET
AZURE_SUBSCRIPTION_ID
AZURE_TENANT_ID
```

These secrets are used by GitHub Actions to authenticate to Azure.

---

## Terraform Plan Output

Terraform plan output can be generated locally using:

```bash
terraform show -no-color dev.tfplan > dev-terraform-plan-output.txt
```

The GitHub Actions workflow also uploads the dev plan output as an artifact.

Plan output helps reviewers verify:

- Resources being created
- Environment-specific values
- Backend state being used
- Security configuration
- No unexpected delete operations

---

## Code Quality

The following practices are used or recommended:

- `terraform fmt`
- `terraform validate`
- Modular Terraform design
- GitHub Actions validation
- Pull request review
- Branch protection

Recommended future tools:

- TFLint
- Checkov
- tfsec
- terraform-docs
- Infracost
- pre-commit hooks

---

## Documentation

Additional documentation is available under:

```text
documentation/
```

Files included:

- `architecture.md`
- `assumptions.md`
- `release-lifecycle.md`
- `terraform-plan-output.md`

---

## Assumptions

Key assumptions:

- Dev and prod use the same Azure subscription for simplicity
- Dev and prod are separated using `.tfvars` files and remote state keys
- Backend resources are created separately before Terraform init
- Production apply is intentionally not automated
- Storage Account and Blob Container are used as the additional resource
- Advanced monitoring and private endpoints are excluded to keep the solution simple

---

## Future Improvements

Future improvements can include:

- Separate Azure subscriptions for dev and prod
- Azure Policy for mandatory tags
- Azure Key Vault integration
- Private endpoints for Storage Account
- Azure Monitor and Log Analytics
- Terraform module testing with Terratest
- Security scanning with Checkov or tfsec
- Cost estimation using Infracost
- GitHub Environment approval gates for production
