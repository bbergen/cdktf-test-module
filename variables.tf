variable "resource_group_name" {
  type        = string
  description = "The resource group to use. If null, a new resource group will be created."
  default     = null
}

variable "storage_account_name" {
  type        = string
  description = "The storage account to use. If null, a new storage account will be created."
  default     = null
}

variable "table_name" {
  type        = string
  description = "The name of the table to create."
}