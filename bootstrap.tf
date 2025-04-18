# ---------- bootstrap.tf ----------
# Creates state storage resources

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tfstate_rg" {
  name     = "tfstate-rg"
  location = "eastus"
}

resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${random_integer.suffix.result}"
  resource_group_name      = azurerm_resource_group.tfstate_rg.name
  location                 = azurerm_resource_group.tfstate_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

output "storage_account_name" {
  value = azurerm_storage_account.tfstate.name
}

output "resource_group_name" {
  value = azurerm_resource_group.tfstate_rg.name
}

output "container_name" {
  value = azurerm_storage_container.tfstate.name
}

output "state_key" {
  value = "terraform.tfstate"
}
