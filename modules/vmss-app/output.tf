# modules/vmss-app/output.tf
output "vmss_app_id" {
  value = azurerm_linux_virtual_machine_scale_set.vmss_app[0].id
}


