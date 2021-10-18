locals {
  create_resource_group  = var.resource_group_name == null
  create_storage_account = var.storage_account_name == null
}

resource "azurerm_resource_group" "new_rgp" {
  count    = local.create_resource_group ? 1 : 0
  name     = "storage-rgp"
  location = "Canada Central"
}

data "azurerm_resource_group" "existing_rgp" {
  count = local.create_resource_group == null ? 0 : 1
  name  = var.resource_group_name
}

resource "azurerm_storage_account" "storage_account" {
  count                    = local.create_storage_account ? 1 : 0
  name                     = "bryanstgacct20211018"
  resource_group_name      = local.create_resource_group ? resource.azurerm_resource_group.new_rgp.name : var.resource_group_name
  location                 = local.create_resource_group ? resource.azurerm_resource_group.new_rgp.location : data.azurerm_resource_group_existing_rgp.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_table" "table" {
  name                 = var.table_name
  storage_account_name = local.create_storage_account ? resource_storage_account.storage_account.name : var.storage_account_name
}
