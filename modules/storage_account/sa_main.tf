locals {
  defaultname = substr(lower(replace("${var.customer}st${var.category}${var.applicationname}${var.environment}", "-", "")), 0, 24)
}

resource "azurerm_storage_account" "main" {
  name                = var.name == "" ? local.defaultname : var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = "StorageV2"

  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false

  tags = var.tags
}

resource "azurerm_storage_container" "main" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}