output "id" {
  value       = azurerm_storage_account.main.id
  description = "The ID of the created storage account."
}

output "storage_account_name" {
  value       = azurerm_storage_account.main.name
  description = "The name of the created storage account."
}

output "primary_blob_endpoint" {
  value       = azurerm_storage_account.main.primary_blob_endpoint
  description = "The primary blob endpoint of the storage account."
}

output "container_name" {
  value       = azurerm_storage_container.main.name
  description = "The name of the created blob container."
}