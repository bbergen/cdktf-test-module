locals {
  create_resource_group    = var.resource_group_name == null
  create_storage_account   = var.storage_account_name == null
  default_location         = "Canada Central"
  default_rgp_name         = "storage-rgp"
  default_stg_acct_name    = "bryanstgacct20211018"
  default_account_tier     = "Standard"
  default_replication_tier = "LRS"
}

resource "azurerm_resource_group" "new_rgp" {
  count    = local.create_resource_group ? 1 : 0
  name     = local.default_rgp_name
  location = local.default_location
}

data "azurerm_resource_group" "existing_rgp" {
  count = local.create_resource_group == null ? 0 : 1
  name  = var.resource_group_name
}

resource "azurerm_storage_account" "storage_account" {
  count                    = local.create_storage_account ? 1 : 0
  name                     = local.default_stg_acct_name
  resource_group_name      = local.create_resource_group ? local.default_rgp_name : var.resource_group_name
  location                 = local.create_resource_group ? local.default_location : data.azurerm_resource_group.existing_rgp[0].location
  account_tier             = local.default_account_tier
  account_replication_type = local.default_replication_tier
}

resource "azurerm_storage_table" "table" {
  name                 = var.table_name
  storage_account_name = local.create_storage_account ? local.default_stg_acct_name : var.storage_account_name
}
