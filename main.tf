provider "azurerm" {
  features {}
  subscription_id = "35644ff4-0bda-4ea2-9454-ede0a5ad758e"  # YOUR SUB ID
}

resource "azurerm_resource_group" "g42" {
  name     = "rg-g42-hunting-india"
  location = "uaenorth"
}

resource "azurerm_log_analytics_workspace" "g42" {
  name                = "uae-north-sentinel"
  location            = azurerm_resource_group.g42.location
  resource_group_name = azurerm_resource_group.g42.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_log_analytics_solution" "g42" {
  solution_name         = "SecurityInsights"
  location              = azurerm_resource_group.g42.location
  resource_group_name   = azurerm_resource_group.g42.name
  workspace_resource_id = azurerm_log_analytics_workspace.g42.id
  workspace_name        = azurerm_log_analytics_workspace.g42.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.g42.id
}
