# Assumptions

## Azure Subscription

- Azure free-tier or a test subscription is used for this challenge.
- Dev and prod are deployed using the same Azure subscription for simplicity.
- In a real enterprise setup, separate Azure subscriptions would be recommended for production and non-production environments.

## Environment Design

- A single Terraform configuration is used for both dev and prod.
- Environment-specific values are passed using separate `.tfvars` files.
- Dev uses `dev.tfvars`.
- Prod uses `prod.tfvars`.
- The same `main.tf` is reused to avoid code duplication.

## Remote Backend

- Terraform remote state is configured using Azure Storage backend.
- Dev and prod use separate backend config files.
- Dev uses `backend-dev.hcl`.
- Prod uses `backend-prod.hcl`.
- Dev state key is `dev.terraform.tfstate`.
- Prod state key is `prod.terraform.tfstate`.
- The backend Resource Group, Storage Account, and container must exist before running `terraform init`.

## Module Design

- Each Terraform module has a single responsibility.
- Resource Group, Virtual Network, Subnet, Network Security Group, and Storage Account are separate modules.
- This structure improves reusability, readability, and maintainability.

## Security

- No secrets are hardcoded in Terraform files.
- Storage Account public blob access is disabled.
- Blob container access is private.
- HTTPS-only traffic is enabled for the Storage Account.
- Minimum TLS version is set to TLS 1.2.
- Network Security Group rules are passed through variables.
- Production apply is not automated to avoid accidental changes.

## CI/CD

- GitHub Actions workflow is manually triggered.
- The workflow applies only the dev environment.
- The workflow does not run automatically on push to main.
- Production deployment is intentionally excluded from automatic apply.
- Terraform plan output is uploaded as a workflow artifact.

## Tags

- Tags are applied to resources for ownership, cost tracking, and governance.
- In a real enterprise setup, mandatory tags can be enforced using Azure Policy.

## Cost

- Resources are kept simple to reduce cost.
- Storage uses Standard LRS replication.
- No high-cost resources are included by default.

## Limitations

- Backend bootstrap is not included in this solution.
- Private endpoints are not included to keep the challenge simple.
- Advanced monitoring and diagnostics are not configured.
- Production deployment is documented but not automated.