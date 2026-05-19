output "id" {
  value       = azurerm_network_security_group.main.id
  description = "The ID of the created network security group."
}

output "network_security_group_name" {
  value       = azurerm_network_security_group.main.name
  description = "The name of the created network security group."
}

output "security_rule_names" {
  value       = [for rule in azurerm_network_security_rule.main : rule.name]
  description = "The names of the created network security rules."
}

output "associated_subnet_ids" {
  value       = [for association in azurerm_subnet_network_security_group_association.main : association.subnet_id]
  description = "The subnet IDs associated with the network security group."
}