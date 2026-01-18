# modules/network/outputs.tf

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "web_subnet_id" {
  value = azurerm_subnet.web-subnet.id
}

output "app_subnet_id" {
  value = azurerm_subnet.app-subnet.id
}

output "internal_subnet_id" {
  value = azurerm_subnet.internal_subnet.id
}


output "bastion_subnet_id" {
  value = azurerm_subnet.bastion_subnet.id
}

output "subnet_private_endpoint_id" {
  value = azurerm_subnet.private_subnet.id
}




output "nsg_web_rules_http_id" {
  value = azurerm_network_security_group.nsg_web_rules_HTTP.id
}

output "nsg_web_rules_ssh_id" {
  value = azurerm_network_security_group.nsg_web_rules_SSH.id
}

output "nsg_app_service_tags_id" {
  value = azurerm_network_security_group.nsg_app_service_tags.id
}

output "nsg_app_ssh_id" {
  value = azurerm_network_security_group.nsg_app_rules_SSH.id
}

output "nsg_app_deny_all_id" {
  value = azurerm_network_security_group.nsg_app_rules_Deny_All.id
}



output "nsg_db_sql_id" {
  value = azurerm_network_security_group.nsg_db_rules_sql.id
}

output "nsg_db_deny_all_id" {
  value = azurerm_network_security_group.nsg_db_rules_Deny_All.id
}

output "nsg_bastion_web_SSH_id" {
  value = azurerm_network_security_group.nsg_bastion_rules_web_SSH.id
}

output "nsg_bastion_app_SSH_id" {
  value = azurerm_network_security_group.nsg_bastion_rules_app_SSH.id
}

output "nsg_bastion_deny_id" {
  value = azurerm_network_security_group.nsg_bastion_rules_Deny_All.id
}