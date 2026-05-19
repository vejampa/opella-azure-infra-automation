variable "name" {
  type        = string
  description = "(Optional) The name of the virtual network. When this value is left empty, the virtual network name is a concatenation of: <customer>-vnet-<category>-<application name>-<environment>."
  default     = ""
}

variable "customer" {
  type        = string
  description = "The customer name of the project."
  default     = ""
}

variable "category" {
  type        = string
  description = "The category the virtual network belongs to. Example values: platform, core, app."
  default     = ""
}

variable "applicationname" {
  type        = string
  description = "The application name of the virtual network."
  default     = ""
}

variable "environment" {
  type        = string
  description = "The environment of the system. Example values: t(team), d(development), tst(test), a(acceptance), p(production), or any other team-defined value."
  default     = ""
}

variable "location" {
  type        = string
  description = "The Azure location of the virtual network."
  default     = "West US"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the virtual network will be created."
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.0.0.0/16"]
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resources."
  default     = {}
}