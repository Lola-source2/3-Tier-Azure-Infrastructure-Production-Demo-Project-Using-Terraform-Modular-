# modules/monitoring/output.tf
output "monitoring_diagnotics_id" {
  value = azurerm_monitor_diagnostic_setting.monitor_diagnostic.id
}


