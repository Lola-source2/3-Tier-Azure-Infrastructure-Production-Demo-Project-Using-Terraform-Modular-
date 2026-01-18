# modules/bastion_admin/main.tf

resource "azurerm_bastion_host" "bastion_host" {
  name                = var.bastion_host[0].name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.bastion_host[0].sku

  ip_configuration {
    name                 = "${var.bastion_host[0].name}_ip_configuration"
    subnet_id            = var.bastion_host[0].ip_configuration[0].subnet_id[0]
    public_ip_address_id = var.bastion_host[0].ip_configuration[0].public_ip_address_id
  }

  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }
}