# environments/dev/main.tf
# Azure Resource Group
resource "azurerm_resource_group" "rg_main" {
  name     = var.resource_group_name
  location = var.location

}

# TLS Private key for SSH

resource "tls_private_key" "ssh_key" {

  algorithm = var.tls_private_key[0].algorithm
  rsa_bits  = tonumber(var.tls_private_key[0].rsa_bits)
}


# Modules Key_Vault
module "key_vault" {

  source              = "../../modules/keyvault"
  key_vault_name      = "kv-prod-001"
  location            = var.location
  resource_group_name = var.resource_group_name


}
# Modules Network

module "network" {

  source                  = "../../modules/network"
  vnet_name               = "vnet-prod-001"
  resource_group_name     = var.resource_group_name
  location                = var.location
  address_space           = ["10.0.0.0/16"]
  web_subnet_prefix       = ["10.0.1.0/24"]
  app_subnet_prefix       = ["10.0.2.0/24"]
  subnet_private_endpoint = ["10.0.3.0/24"]

  internal_private_subnet = [{
    name           = "internal-subnet"
    address_prefix = ["10.0.5.0/24"]
  }]




}
# Modules Bastion Host

module "bastion_admin" {

  source              = "../../modules/bastion_admin"
  location            = var.location
  resource_group_name = var.resource_group_name


  bastion_host = [{
    name = "bastion-host-001"
    sku  = "Standard"

    ip_configuration = [{
      name                 = "bastion-ip-config-001"
      subnet_id            = [module.network.bastion_subnet_id]
      public_ip_address_id = module.bastion_public_ip.bastion_public_ip_id
    }]

  }]
}

# Modules Bastion Public IP


module "bastion_public_ip" {
  source              = "../../modules/bastion_public_ip"
  location            = var.location
  resource_group_name = var.resource_group_name

  public_ip_bastion = [{
    name              = "bastion-public-ip-001"
    sku               = "Standard"
    allocation_method = "Static"
  }]
}

# Modules LB Public IP

module "lb-public-ip" {

  source              = "../../modules/lb-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name

  public_ip_lb = [{
    name              = "lb-public-ip-001"
    sku               = "Standard"
    allocation_method = "Static"
  }]

}

# Modules Database

module "database" {
  source              = "../../modules/database"
  db_server_name      = "sqlserver-prod-001"
  location            = var.location
  resource_group_name = var.resource_group_name

  vnet_id                 = module.network.vnet_id
  subnet_private_endpoint = module.network.subnet_private_endpoint_id

  # database login credentials secretly stored in key vault

  db_kv_secret = [{
    name         = "db-admin-password"
    key_vault_id = module.key_vault.key_vault_id
    value        = var.db_password
    content_type = "Secret for DB Admin Password"
  }]

# db connection string stored in key vault
  db_connection_string = [{
    name         = "db-connection-string"
    value        = var.db_connection_string
    key_vault_id = module.key_vault.key_vault_id
    content_type = "Secret for DB Connection String"
  }]


}


# Modules VMSS Web


module "vmss_web" {
  source              = "../../modules/vmss-web"
  location            = var.location
  resource_group_name = var.resource_group_name
  vmss_web_name       = "vmss-web-prod-001"
  web_subnet_id       = module.network.web_subnet_id

  # Network Interface Configuration
  
  network_interface = [{
    name    = "nic-web-001"
    primary = true

    ip_configuration = [{
      name      = "ipconfig-web-001"
      subnet_id = module.network.web_subnet_id
      primary   = true

    }]

  }]

# SSH Key Configuration

  ssh_key = [{
    name         = "ssh-public-key"
    value        = tls_private_key.ssh_key.public_key_openssh
    key_vault_id = module.key_vault.key_vault_id
  }]


  admin_ssh_key = [{
    username   = var.admin_username
    public_key = tls_private_key.ssh_key.public_key_openssh
  }]






}

# Modules VMSS App

module "vmss-app" {
  source              = "../../modules/vmss-app"
  vmss_app_name       = "vmss-app-prod-001"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_subnet_id       = module.network.app_subnet_id
  db_name             = module.database.db_name

# Network Interface Configuration

  network_interface = [{
    name    = "nic-app-001"
    primary = true

    ip_configuration = [{
      name      = "ipconfig-app-001"
      subnet_id = module.network.app_subnet_id
      primary   = true

    }]
  }]

# SSH Key Configuration

  ssh_key = [{
    name         = "ssh-public-key"
    value        = tls_private_key.ssh_key.public_key_openssh
    key_vault_id = module.key_vault.key_vault_id
  }]

  admin_ssh_key = [{
    username   = var.admin_username
    public_key = tls_private_key.ssh_key.public_key_openssh
  }]




}

# Modules Public LB

module "public_lb" {
  source              = "../../modules/public_lb"
  lb_name             = "lb-prod-001"
  location            = var.location
  resource_group_name = var.resource_group_name


  frontend_ip_configurations = [{
    name                 = "fe-ipconfig-001"
    public_ip_address_id = module.lb-public-ip.public_ip_id
  }]



}

# Modules Internal LB

module "internal_lb" {

  source              = "../../modules/internal_lb"
  internal_lb_name    = "internal-lb-prod-001"
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration = [{
    name = "internal-fe-ipconfig-001"

    private_ip_address_id = module.network.internal_subnet_id
  }]



}

# Modules Log Analytic Workspace

module "log_analytic_workspace" {

  source              = "../../modules/log_analytic_workspace"
  location            = var.location
  resource_group_name = var.resource_group_name

  log_analytics_workspace = [{
    name              = "LAW-prod-001"
    sku               = "PerGB2018"
    retention_in_days = 30
  }]


}

# Modules Monitoring

module "monitoring" {
  source              = "../../modules/monitoring"
  location            = var.location
  resource_group_name = var.resource_group_name

# Diagnostic Setting for VMSS Web and App

  monitor_diagnostic_setting = [{
    name                       = "monitor-diagnostic-setting-001"
    target_resource_id         = module.database.sql_server_id
    log_analytics_workspace_id = module.log_analytic_workspace.log_analytics_workspace_id

    enabled_logs = [{
      category = "SQSecurityAuditEvents"

    }]
    enabled_metrics = [{
      category = "AllMetrics"

    }]
  }]

# Metric Alert for CPU Utilization

  monitor_metric_alert = [{
    name        = "metric-alert-cpu-001"
    description = "CPU Utilization Alert"
    severity    = 3
    enabled     = true

    window_size = "PT5M"
    scopes      = [module.vmss_web.vmss_web_id, module.vmss-app.vmss_app_id]

    critical = [{
      threshold        = 80
      operator         = "GreaterThan"
      aggregation      = "Average"
      metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
      metric_name      = "Percentage CPU"
    }]
  }]


}





