# modules/database/variables.tf

variable "db_name" {
  type    = string
  default = "sqldb-prod-001"
}


variable "vnet_id" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}


variable "tags" {
  type = map(string)
  default = {
    Owner       = "CloudTeam"
    environment = "Production"
  }
}


variable "location" {
  type    = string
  default = "North Europe"
}


variable "db_kv_secret" {
  type = list(object({
    name         = string
    value        = string
    key_vault_id = string
    content_type = string
  }))
  default = [{
    name         = "db-password"
    value        = ""
    key_vault_id = ""
    content_type = ""
    }

  ]
  sensitive = true
}

variable "db_admin" {
  type      = string
  default   = ""
  sensitive = true
}


variable "db_password" {
  type      = string
  default   = ""
  sensitive = true
}



variable "resource_group_name" {
  type    = string
  default = "rg-prod-001"
}

variable "db_server_name" {
  type    = string
  default = "sqlserver-prod-001"
}



variable "subnet_private_endpoint" {
  type    = string
  default = "10.0.3.0/24"
}


variable "db_version" {
  type    = string
  default = "12.0"
}


variable "collation" {
  type    = string
  default = "SQL_Latin1_General_CP1_CI_AS"
}

variable "license_type" {
  type    = string
  default = "LicenseIncluded"
}


variable "max_size_gb" {
  type    = number
  default = 2
}

variable "enclave_type" {
  type    = string
  default = "VBS"
}




variable "sku_tier" {
  type    = string
  default = "Basic"
}


variable "sku_name" {
  type    = string
  default = "SO"
}


variable "private_service_connection" {
  type = list(object({
    name                           = string
    private_connection_resource_id = string
    is_manual_connection           = bool
    subresource_names              = list(string)
  }))

  default = [{
    name                           = "sqldb-pe-psc"
    private_connection_resource_id = ""
    is_manual_connection           = false
    subresource_names              = ["sqlDatabase"]
  }]

}

variable "db_connection_string" {
  type = list(object({
    name         = string
    value        = string
    key_vault_id = string
    content_type = string
  }))
  default = [{
    name         = "db-connection-string"
    value        = ""
    key_vault_id = ""
    content_type = ""
  }]
  sensitive = true
}


