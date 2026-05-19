locals {
  defaultname = "${var.customer}-snet-${var.category}-${var.applicationname}-${var.environment}"
}

resource "azurerm_subnet" "main" {
  name                 = var.name == "" ? local.defaultname : var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}