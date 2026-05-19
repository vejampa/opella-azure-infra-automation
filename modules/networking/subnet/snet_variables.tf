variable "name" {
  type        = string
  description = "(Optional) The name of the subnet. When this value is left empty, the subnet name is a concatenation of: <customer>-snet-<category>-<application name>-<environment>."
  default     = ""
}

variable "customer" {
  type        = string
  description = "The customer name of the project."
  default     = ""
}

variable "category" {
  type        = string
  description = "The category the subnet belongs to. Example values: platform, core, app."
  default     = ""
}

variable "applicationname" {
  type        = string
  description = "The application name of the subnet."
  default     = ""
}

variable "environment" {
  type        = string
  description = "The environment of the system. Example values: t(team), d(development), tst(test), a(acceptance), p(production), or any other team-defined value."
  default     = ""
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the subnet will be created."
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network in which the subnet will be created."
}

variable "address_prefixes" {
  type        = list(string)
  description = "The address prefixes to use for the subnet."
}