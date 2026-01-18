# modules/keyvault/main.tf
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name                   = var.key_vault_sku_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = var.key_vault[0].soft_delete_retention_days
  purge_protection_enabled   = var.key_vault[0].purge_protection_enabled


  enable_rbac_authorization = var.key_vault[0].enable_rbac_authorization


  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }
}



resource "azurerm_role_assignment" "key_vault_role_assignment" {
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = var.key_vault_role_assignment[0].role_definition_name
  principal_id         = data.azurerm_client_config.current.object_id


  depends_on = [azurerm_key_vault.key_vault]


}


resource "azurerm_role_assignment" "vmss_app_id_role_assignment" {
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = var.vmss_app_id_role_assignment[0].role_definition_name
  principal_id         = data.azurerm_client_config.current.object_id




}