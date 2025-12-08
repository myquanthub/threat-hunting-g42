provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "g42" {
  name     = "rg-g42-hunting-india"
  location = "centralindia"
}

resource "azurerm_log_analytics_workspace" "g42" {
  name                = "law-g42-hunting-001"
  location            = azurerm_resource_group.g42.location
  resource_group_name = azurerm_resource_group.g42.name
  sku                 = "Free"
}

resource "azurerm_sentinel_workspace" "g42" {
  workspace_id = azurerm_log_analytics_workspace.g42.id
}
