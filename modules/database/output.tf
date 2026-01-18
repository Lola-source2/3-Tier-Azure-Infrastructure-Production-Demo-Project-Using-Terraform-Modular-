# modules/database/output.tf
output "db_name" {
  value = azurerm_mssql_server.sql_server.name
}



output "sql_server_id" {
  value     = azurerm_mssql_server.sql_server.id
  sensitive = true
}

output "private_endpoint_id" {
  value     = azurerm_private_endpoint.private_endpoint.id
  sensitive = true
}




