locals {
  defaultname = "${var.customer}-vnet-${var.category}-${var.applicationname}-${var.environment}"
}

resource "azurerm_virtual_network" "main" {
  name                = var.name == "" ? local.defaultname : var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  tags = var.tags
}