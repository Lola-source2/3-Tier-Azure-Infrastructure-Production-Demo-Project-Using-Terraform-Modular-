# modules/public_LB/output.tf
output "load_balancer_id" {
  value = azurerm_lb.public_lb.id
}



output "load_balancer_backend_address_pool_id" {
  value = azurerm_lb_backend_address_pool.backend_web_pool.id
}







