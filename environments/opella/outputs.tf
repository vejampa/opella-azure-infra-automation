output "resource_group_id" {
  value       = module.resource_group.id
  description = "The ID of the created resource group."
}

output "resource_group_name" {
  value       = module.resource_group.resource_group_name
  description = "The name of the created resource group."
}

output "virtual_network_id" {
  value       = module.virtual_network.id
  description = "The ID of the created virtual network."
}

output "virtual_network_name" {
  value       = module.virtual_network.virtual_network_name
  description = "The name of the created virtual network."
}

output "subnet_id" {
  value       = module.subnet.id
  description = "The ID of the created subnet."
}

output "subnet_name" {
  value       = module.subnet.subnet_name
  description = "The name of the created subnet."
}

output "network_security_group_id" {
  value       = module.network_security_group.id
  description = "The ID of the created network security group."
}

output "network_security_group_name" {
  value       = module.network_security_group.network_security_group_name
  description = "The name of the created network security group."
}

output "security_rule_names" {
  value       = module.network_security_group.security_rule_names
  description = "The names of the created network security rules."
}

output "associated_subnet_ids" {
  value       = module.network_security_group.associated_subnet_ids
  description = "The subnet IDs associated with the network security group."
}

output "storage_account_id" {
  value       = module.storage_account.id
  description = "The ID of the created storage account."
}

output "storage_account_name" {
  value       = module.storage_account.storage_account_name
  description = "The name of the created storage account."
}

output "primary_blob_endpoint" {
  value       = module.storage_account.primary_blob_endpoint
  description = "The primary blob endpoint of the storage account."
}

output "blob_container_name" {
  value       = module.storage_account.container_name
  description = "The name of the created private blob container."
}