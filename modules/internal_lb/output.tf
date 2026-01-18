# modules/internal_LB/output.tf
output "load_balancer_id" {
  value = azurerm_lb.internal_lb.id
}



output "internal_lb_backend_id" {
  value = azurerm_lb_backend_address_pool.internal_lb_backend.id
}