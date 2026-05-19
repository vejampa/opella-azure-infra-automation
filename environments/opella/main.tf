module "resource_group" {
  source = "../../modules/resource_group"

  name            = var.resource_group_name
  customer        = var.customer
  category        = var.category
  applicationname = var.applicationname
  environment     = var.environment
  location        = var.location

  tags = var.tags
}

module "virtual_network" {
  source = "../../modules/networking/virtual_network"

  name                = var.virtual_network_name
  customer            = var.customer
  category            = var.category
  applicationname     = var.applicationname
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  address_space = var.vnet_address_space

  tags = var.tags
}

module "subnet" {
  source = "../../modules/networking/subnet"

  name                 = var.subnet_name
  customer             = var.customer
  category             = var.category
  applicationname      = var.applicationname
  environment          = var.environment
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.virtual_network_name

  address_prefixes = var.subnet_address_prefixes
}

module "network_security_group" {
  source = "../../modules/networking/network_security_group"

  name                = var.network_security_group_name
  customer            = var.customer
  category            = var.category
  applicationname     = var.applicationname
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  subnet_ids = {
    app = module.subnet.id
  }

  security_rules = var.security_rules

  tags = var.tags
}

module "storage_account" {
  source = "../../modules/storage_account"

  name                = var.storage_account_name
  customer            = var.customer
  category            = var.category
  applicationname     = var.applicationname
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  container_name           = var.container_name

  tags = var.tags
}