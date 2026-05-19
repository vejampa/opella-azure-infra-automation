variable "name" {
  type        = string
  description = "(Optional) The name of the storage account. When this value is left empty, the storage account name is generated using customer, category, application name, and environment."
  default     = ""
}

variable "customer" {
  type        = string
  description = "The customer name of the project."
  default     = ""
}

variable "category" {
  type        = string
  description = "The category the storage account belongs to. Example values: platform, core, app."
  default     = ""
}

variable "applicationname" {
  type        = string
  description = "The application name of the storage account."
  default     = ""
}

variable "environment" {
  type        = string
  description = "The environment of the system. Example values: d(development), t(test), a(acceptance), p(production)."
  default     = ""
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the storage account will be created."
}

variable "location" {
  type        = string
  description = "The Azure location of the storage account."
  default     = "West US"
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

variable "container_name" {
  type        = string
  description = "The name of the private blob container."
  default     = "appdata"
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resources."
  default     = {}
}