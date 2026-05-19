variable "name" {
  type        = string
  description = "(Optional) The name of the network security group. When this value is left empty, the network security group name is a concatenation of: <customer>-nsg-<category>-<application name>-<environment>."
  default     = ""
}

variable "customer" {
  type        = string
  description = "The customer name of the project."
  default     = ""
}

variable "category" {
  type        = string
  description = "The category the network security group belongs to. Example values: platform, core, app."
  default     = ""
}

variable "applicationname" {
  type        = string
  description = "The application name of the network security group."
  default     = ""
}

variable "environment" {
  type        = string
  description = "The environment of the system. Example values: t(team), d(development), tst(test), a(acceptance), p(production), or any other team-defined value."
  default     = ""
}

variable "location" {
  type        = string
  description = "The Azure location of the network security group."
  default     = "West US"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the network security group will be created."
}

variable "subnet_ids" {
  type        = map(string)
  description = "A map of subnet IDs where the network security group should be associated."
  default     = {}
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

  description = "A map of network security rules to create inside the network security group."
  default     = {}
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resources."
  default     = {}
}