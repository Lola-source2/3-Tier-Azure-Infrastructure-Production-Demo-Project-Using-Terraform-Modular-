# modules/database/main.tf

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.db_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.db_version
  administrator_login          = var.db_admin
  administrator_login_password = var.db_password

  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }




}

resource "azurerm_key_vault_secret" "db_kv_secret" {
  name         = var.db_kv_secret[0].name
  value        = var.db_kv_secret[0].value
  key_vault_id = var.db_kv_secret[0].key_vault_id
  content_type = var.db_kv_secret[0].content_type


  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }
}



resource "azurerm_mssql_database" "sql_database" {
  name         = var.db_name
  server_id    = azurerm_mssql_server.sql_server.id
  collation    = var.collation
  license_type = var.license_type
  max_size_gb  = var.max_size_gb
  sku_name     = var.sku_name


  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }
}

resource "azurerm_key_vault_secret" "db_connection_string" {
  name         = var.db_connection_string[0].name
  value        = var.db_connection_string[0].value
  key_vault_id = var.db_connection_string[0].key_vault_id
  content_type = var.db_connection_string[0].content_type

  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }
}



resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "${var.db_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_private_endpoint


  private_service_connection {
    name                           = var.private_service_connection[0].name
    private_connection_resource_id = azurerm_mssql_database.sql_database.id
    is_manual_connection           = var.private_service_connection[0].is_manual_connection
    subresource_names              = var.private_service_connection[0].subresource_names
  }


  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }

}






