# modules/log_analytic_workspace/main.tf

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = var.log_analytics_workspace[0].name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_workspace[0].sku
  retention_in_days   = var.log_analytics_workspace[0].retention_in_days


  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }

}

