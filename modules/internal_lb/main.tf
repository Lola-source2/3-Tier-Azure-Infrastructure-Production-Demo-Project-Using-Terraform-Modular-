# modules/internal_LB/main.tf
resource "azurerm_lb" "internal_lb" {
  name                = var.internal_lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.lb_sku


  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }


  frontend_ip_configuration {
    name               = var.frontend_ip_configuration[0].name
    private_ip_address = var.frontend_ip_configuration[0].private_ip_address_id

  }

}


resource "azurerm_lb_probe" "internal_lb_probes" {

  name                = var.internal_probes[0].name
  protocol            = var.internal_probes[0].protocol
  loadbalancer_id     = azurerm_lb.internal_lb.id
  port                = var.internal_probes[0].port
  interval_in_seconds = var.internal_probes[0].interval_in_seconds
  number_of_probes    = var.internal_probes[0].number_of_probes
  request_path        = var.internal_probes[0].request_path



}

resource "azurerm_lb_rule" "internal_lb-rule" {

  name                           = var.load_balancer_rules[0].name
  loadbalancer_id                = azurerm_lb.internal_lb.id
  protocol                       = var.load_balancer_rules[0].protocol
  frontend_ip_configuration_name = var.load_balancer_rules[0].frontend_ip_configuration_name

  frontend_port           = var.load_balancer_rules[0].frontend_port
  backend_port            = var.load_balancer_rules[0].backend_port
  enable_floating_ip      = var.load_balancer_rules[0].enable_floating_ip
  probe_id                = azurerm_lb_probe.internal_lb_probes.id
  idle_timeout_in_minutes = var.load_balancer_rules[0].idle_timeout_in_minutes

}





resource "azurerm_lb_nat_pool" "inbound_nat_pool" {
  resource_group_name = var.resource_group_name

  name                           = var.inbound_nat_pools[0].name
  loadbalancer_id                = azurerm_lb.internal_lb.id
  protocol                       = var.inbound_nat_pools[0].protocol
  frontend_ip_configuration_name = var.inbound_nat_pools[0].frontend_ip_configuration_name
  frontend_port_start            = var.inbound_nat_pools[0].frontend_port_start
  frontend_port_end              = var.inbound_nat_pools[0].frontend_port_end
  backend_port                   = var.inbound_nat_pools[0].backend_port


}




resource "azurerm_lb_backend_address_pool" "internal_lb_backend" {
  name            = var.internal_lb_backend[0].name
  loadbalancer_id = azurerm_lb.internal_lb.id
}