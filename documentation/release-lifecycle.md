# Release Lifecycle

## Overview

This repository uses GitHub Actions to validate, plan, and deploy Terraform infrastructure.

The workflow is designed to be simple, controlled, and safe for the challenge. It is manually triggered and applies only the dev environment.

---

## Branching Strategy

The recommended branching flow is:

```text
feature branch
    ↓
pull request
    ↓
review
    ↓
merge to main
    ↓
manual workflow trigger
    ↓
terraform plan and apply for dev
```

This keeps infrastructure changes reviewable before they are applied.

---

## Workflow Trigger

The Terraform workflow is triggered manually using GitHub Actions `workflow_dispatch`.

The workflow does not run automatically on push to the `main` branch. This avoids accidental infrastructure changes.

---

## Dev Deployment

The dev environment is deployed using:

```text
dev.tfvars
backend-dev.hcl
```

The workflow performs the following steps:

1. Checkout repository
2. Setup Terraform
3. Azure login
4. Terraform format check
5. Terraform init using dev backend
6. Terraform validate
7. Terraform plan using dev variables
8. Save Terraform plan output
9. Upload Terraform plan output as an artifact
10. Terraform apply for dev

---

## Production Deployment

Production deployment is intentionally not automated.

The production environment has its own configuration files:

```text
prod.tfvars
backend-prod.hcl
```

Production apply should normally require:

- Pull request review
- Manual approval
- Change validation
- Controlled deployment window
- Separate Azure credentials or service principal
- Separate Terraform state file

---

## Terraform Apply Strategy

Only dev apply is enabled in the current GitHub Actions workflow.

This is intentional because dev infrastructure can be safely tested, while production changes should be reviewed and approved before deployment.

Recommended production deployment flow:

```text
terraform plan -var-file="prod.tfvars"
    ↓
manual review
    ↓
manual approval
    ↓
terraform apply
```

---

## Plan Output

Terraform plan output is generated before apply.

The plan output helps reviewers verify:

- What resources will be created
- What resources will be updated
- What resources will be deleted
- Which environment configuration is being used
- Whether the correct backend state is being used

The GitHub Actions workflow uploads the plan output as an artifact for review.


## Recommended Improvements

For a production-grade setup, the following improvements are recommended:

- GitHub Environment approvals
- Branch protection rules
- Pull request policies
- Separate service principals for dev and prod
- Terraform plan review before apply
- TFLint validation
- Checkov or tfsec security scanning
- Infracost cost estimation
- Azure Policy enforcement
- Automated module testing using Terratest
