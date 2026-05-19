# Architecture

## Overview

This repository contains a Terraform-based Azure infrastructure automation solution for Opella.

The solution is designed using reusable Terraform modules, a single environment configuration, separate environment variable files, and Azure remote backend state management.

The same Terraform configuration is reused for both `dev` and `prod`. Environment-specific values are managed through `.tfvars` files.

---

## Architecture Components

The solution provisions the following Azure resources:

- Resource Group
- Virtual Network
- Subnet
- Network Security Group
- Subnet to Network Security Group association
- Storage Account
- Private Blob Container

---

## Module Structure

```text
modules/
├── resource_group/
├── networking/
│   ├── virtual_network/
│   ├── subnet/
│   └── network_security_group/
└── storage_account/
```

Each module has a single responsibility. This makes the code easier to maintain, reuse, test, and extend.

### Module Responsibilities

| Module | Responsibility |
|---|---|
| `resource_group` | Creates the Azure Resource Group |
| `virtual_network` | Creates the Azure Virtual Network |
| `subnet` | Creates the subnet inside the Virtual Network |
| `network_security_group` | Creates NSG, NSG rules, and subnet association |
| `storage_account` | Creates Storage Account and private Blob Container |

---

## Environment Structure

```text
environments/
└── opella/
    ├── backend.tf
    ├── backend-dev.hcl
    ├── backend-prod.hcl
    ├── main.tf
    ├── outputs.tf
    ├── providers.tf
    ├── variables.tf
    ├── versions.tf
    ├── dev.tfvars
    └── prod.tfvars
```

The same `main.tf` is used for both dev and prod.

Environment-specific values are controlled through:

- `dev.tfvars`
- `prod.tfvars`

Backend state configuration is controlled through:

- `backend-dev.hcl`
- `backend-prod.hcl`

This avoids code duplication and keeps the deployment process consistent across environments.

---

## Environment Separation

For this challenge, dev and prod are separated using different variable files and different Terraform remote state keys.

Example:

```text
dev.terraform.tfstate
prod.terraform.tfstate
```

This prevents dev and prod resources from sharing the same Terraform state file.

In a real enterprise environment, separate Azure subscriptions are recommended for production and non-production workloads. This provides stronger isolation, better RBAC boundaries, improved governance, and clearer cost tracking.

---

## Networking Design

The networking layer includes:

- Azure Virtual Network
- Dedicated Subnet
- Network Security Group
- Subnet to NSG association

The Network Security Group module accepts security rules through variables. This allows dev and prod to define environment-specific security rules without changing the common `main.tf`.

Example:

- Dev can include limited SSH access if required.
- Prod can keep security rules restricted or empty based on requirements.

---

## Storage Design

The Storage Account module creates:

- Azure Storage Account
- Private Blob Container

Security-focused settings include:

- Public blob access disabled
- Blob container set to private
- HTTPS-only traffic enabled
- Minimum TLS version set to TLS 1.2

This keeps the storage configuration simple while still following basic security best practices.

---

## Remote State Design

Terraform remote state is configured using the AzureRM backend.

The `backend.tf` file contains the backend type:

```hcl
terraform {
  backend "azurerm" {}
}
```

The actual backend values are passed using separate backend config files.

Dev backend:

```text
backend-dev.hcl
```

Prod backend:

```text
backend-prod.hcl
```

This approach is used because Terraform backend configuration cannot be passed through normal `.tfvars` files.

The backend Resource Group, Storage Account, and Container must exist before running `terraform init`.

---

## Provider and Version Design

Terraform provider version constraints are maintained separately in:

```text
versions.tf
```

Provider configuration is maintained in:

```text
providers.tf
```

This separation keeps the configuration clean:

- `versions.tf` controls Terraform and provider versions.
- `providers.tf` controls provider setup.

---

## CI/CD Design

GitHub Actions is used for deployment automation.

The workflow:

- Runs only through manual trigger
- Does not run automatically on push to `main`
- Initializes Terraform using dev backend
- Runs Terraform format check
- Runs Terraform validate
- Generates Terraform plan
- Uploads Terraform plan output
- Applies only the dev environment

Production apply is intentionally not automated to avoid accidental production changes.

---

## Deployment Flow

```text
Developer
   ↓
Feature Branch
   ↓
Pull Request / Review
   ↓
Merge to Main
   ↓
Manual GitHub Actions Trigger
   ↓
Terraform Init
   ↓
Terraform Validate
   ↓
Terraform Plan
   ↓
Terraform Apply for Dev
```

---

## Security Considerations

Security choices included in this design:

- No secrets are hardcoded
- Terraform state files are not committed to Git
- Public blob access is disabled
- Blob container is private
- HTTPS-only traffic is enabled
- Minimum TLS version is set to TLS 1.2
- NSG rules are controlled using variables
- Dev and prod use separate state files
- Production apply is not automated

---

## Future Improvements

Future improvements can include:

- Separate Azure subscriptions for dev and prod
- Azure Policy for mandatory tags
- Azure Key Vault for secret management
- Private endpoints for Storage Account
- Azure Monitor and Log Analytics
- Terraform testing using Terratest
- Security scanning using Checkov or tfsec
- TFLint for Terraform linting
- Infracost for cost estimation
- GitHub Environment approval gates for production
