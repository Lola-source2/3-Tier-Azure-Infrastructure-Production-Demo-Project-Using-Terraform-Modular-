# modules/lb-public-ip/main.tf
resource "azurerm_public_ip" "lb_public_ip" {
  name                = var.public_ip_lb[0].name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.public_ip_lb[0].sku
  allocation_method   = var.public_ip_lb[0].allocation_method

  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }
}