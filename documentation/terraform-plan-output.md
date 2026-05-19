# Terraform Plan Output

## Purpose

Terraform plan output shows the infrastructure changes Terraform will make before applying them.

For this solution, Terraform plan output is generated before deployment and can be reviewed to confirm the expected resources, environment values, and security configuration.

---

## Dev Plan Command

Run the following commands from the `environments/opella` directory:

```bash
terraform init -backend-config="backend-dev.hcl"
terraform validate
terraform plan -var-file="dev.tfvars" -out="dev.tfplan"
terraform show -no-color dev.tfplan > dev-terraform-plan-output.txt
```

---

## Prod Plan Command

Run the following commands from the `environments/opella` directory:

```bash
terraform init -reconfigure -backend-config="backend-prod.hcl"
terraform validate
terraform plan -var-file="prod.tfvars" -out="prod.tfplan"
terraform show -no-color prod.tfplan > prod-terraform-plan-output.txt
```

---

## Expected Dev Resources

The dev plan is expected to create:

- Azure Resource Group
- Azure Virtual Network
- Azure Subnet
- Azure Network Security Group
- Network Security Group rules
- Subnet to Network Security Group association
- Azure Storage Account
- Private Blob Container

---

## Expected Prod Resources

The prod plan is expected to create:

- Azure Resource Group
- Azure Virtual Network
- Azure Subnet
- Azure Network Security Group
- Subnet to Network Security Group association
- Azure Storage Account
- Private Blob Container

---

## GitHub Actions Plan Output

The GitHub Actions workflow generates the dev Terraform plan output and uploads it as a workflow artifact.

Artifact name:

```text
dev-terraform-plan-output
```

The artifact can be downloaded from the GitHub Actions workflow run.

---

## Review Checklist

Before applying Terraform changes, review the plan output and confirm:

- Expected resources are being created
- No unexpected resources are being deleted
- Correct environment values are being used
- Correct backend state file is being used
- Network Security Group rules are correct
- Storage Account public access is disabled
- Blob container access is private
- Tags are applied correctly

---

## Important Notes

Do not commit binary Terraform plan files.

Do not commit:

```text
*.tfplan
tfplan
*.tfstate
*.tfstate.*
```

Only text-based plan output should be committed or shared if required.

---

## Example

A successful Terraform plan should show resources to be created and should not show unexpected delete operations.

Example summary:

```text
Plan: 7 to add, 0 to change, 0 to destroy.
```
