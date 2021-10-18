terraform {
  required_version = "~> 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.56"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

module "test_storage_account" {
  source               = "../"
  resource_group_name  = "test-bbergen"
  storage_account_name = null
  table_name           = "testtable01"
}

