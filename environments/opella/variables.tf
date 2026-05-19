variable "customer" {
  type        = string
  description = "The customer name of the project."
}

variable "category" {
  type        = string
  description = "The category the cloud resources belong to. Example values: platform, core, app."
}

variable "applicationname" {
  type        = string
  description = "The application name."
}

variable "environment" {
  type        = string
  description = "The environment of the system. Example values: d(development), t(test), a(acceptance), p(production)."
}

variable "location" {
  type        = string
  description = "The Azure location where resources will be created."
}

variable "resource_group_name" {
  type        = string
  description = "Optional custom resource group name. Leave empty to use module default naming."
  default     = ""
}

variable "virtual_network_name" {
  type        = string
  description = "Optional custom virtual network name. Leave empty to use module default naming."
  default     = ""
}

variable "subnet_name" {
  type        = string
  description = "Optional custom subnet name. Leave empty to use module default naming."
  default     = ""
}

variable "network_security_group_name" {
  type        = string
  description = "Optional custom network security group name. Leave empty to use module default naming."
  default     = ""
}

variable "storage_account_name" {
  type        = string
  description = "Optional custom storage account name. Leave empty to use module default naming."
  default     = ""
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space for the virtual network."
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefixes for the subnet."
}

variable "security_rules" {
  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))

  description = "A map of network security rules to create in the network security group."
  default     = {}
}

variable "container_name" {
  type        = string
  description = "The private blob container name."
  default     = "appdata"
}

variable "account_tier" {
  type        = string
  description = "The storage account tier."
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "The storage account replication type."
  default     = "LRS"
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resources."
  default     = {}
}