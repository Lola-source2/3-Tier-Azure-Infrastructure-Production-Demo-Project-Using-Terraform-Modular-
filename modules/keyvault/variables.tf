# modules/keyvault/variables.tf
variable "key_vault_name" {
  description = "The name of the key vault"
  type        = string
  default     = "kv-prod-001"

}

variable "resource_group_name" {
  type    = string
  default = "rg-prod-001"
}

variable "location" {
  type    = string
  default = "North Europe"
}

variable "key_vault_sku_name" {
  type    = string
  default = "Standard"
}


variable "key_vault" {
  type = list(object({
    sku_name                   = string
    tenant_id                  = string
    soft_delete_retention_days = number
    purge_protection_enabled   = bool

    enable_rbac_authorization = bool
  }))

  default = [{
    sku_name                   = "Standard"
    tenant_id                  = ""
    soft_delete_retention_days = 7
    purge_protection_enabled   = false
    enable_rbac_authorization  = true
  }]


}


variable "tags" {
  type = map(string)
  default = {
    Owner       = "CloudTeam"
    environment = "Production"
  }
}




variable "key_vault_role_assignment" {
  type = list(object({
    scope                = string
    principal_id         = string
    role_definition_name = string


  }))
  default = [{
    scope                = ""
    principal_id         = ""
    role_definition_name = "Key Vault Crypto User"

  }]

}


variable "vmss_app_id_role_assignment" {
  type = list(object({
    scope                = string
    principal_id         = string
    role_definition_name = string
  }))

  default = [{
    scope                = ""
    principal_id         = ""
    role_definition_name = "Vmss App ID Role Assignment"

  }]

}


