output "id" {
  value       = azurerm_subnet.main.id
  description = "The ID of the created subnet."
}

output "subnet_name" {
  value       = azurerm_subnet.main.name
  description = "The name of the created subnet."
}

output "address_prefixes" {
  value       = azurerm_subnet.main.address_prefixes
  description = "The address prefixes of the created subnet."
}