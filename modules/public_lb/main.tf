# modules/public_LB/main.tf
resource "azurerm_lb" "public_lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.lb_sku


  frontend_ip_configuration {
    name                 = var.frontend_ip_configurations[0].name
    public_ip_address_id = var.frontend_ip_configurations[0].public_ip_address_id

  }
  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }

}


resource "azurerm_lb_probe" "lb_probes" {

  name                = var.probes[0].name
  protocol            = var.probes[0].protocol
  loadbalancer_id     = azurerm_lb.public_lb.id
  port                = var.probes[0].port
  interval_in_seconds = var.probes[0].interval_in_seconds
  number_of_probes    = var.probes[0].number_of_probes
  request_path        = var.probes[0].request_path



}


resource "azurerm_lb_rule" "lb_rules" {

  name                           = var.load_balancer_rules[0].name
  loadbalancer_id                = azurerm_lb.public_lb.id
  protocol                       = var.load_balancer_rules[0].protocol
  frontend_port                  = var.load_balancer_rules[0].frontend_port
  backend_port                   = var.load_balancer_rules[0].backend_port
  frontend_ip_configuration_name = var.load_balancer_rules[0].frontend_ip_configuration_name

  probe_id                = azurerm_lb_probe.lb_probes.id
  enable_floating_ip      = var.load_balancer_rules[0].enable_floating_ip
  idle_timeout_in_minutes = var.load_balancer_rules[0].idle_timeout_in_minutes





}



resource "azurerm_lb_nat_pool" "inbound_nat_pool" {
  resource_group_name = var.resource_group_name

  name                           = var.inbound_nat_pools[0].name
  frontend_ip_configuration_name = var.inbound_nat_pools[0].name
  loadbalancer_id                = azurerm_lb.public_lb.id
  protocol                       = var.inbound_nat_pools[0].protocol
  frontend_port_start            = var.inbound_nat_pools[0].frontend_port_start
  frontend_port_end              = var.inbound_nat_pools[0].frontend_port_end
  backend_port                   = var.inbound_nat_pools[0].backend_port
}




resource "azurerm_lb_backend_address_pool" "backend_web_pool" {

  name            = var.backend_web_pool[0].name
  loadbalancer_id = azurerm_lb.public_lb.id

}