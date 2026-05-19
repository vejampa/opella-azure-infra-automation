output "id" {
  value       = azurerm_virtual_network.main.id
  description = "The ID of the created virtual network."
}

output "virtual_network_name" {
  value       = azurerm_virtual_network.main.name
  description = "The name of the created virtual network."
}

output "address_space" {
  value       = azurerm_virtual_network.main.address_space
  description = "The address space of the created virtual network."
}