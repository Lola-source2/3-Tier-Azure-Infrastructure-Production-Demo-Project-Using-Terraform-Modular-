# Terraform Variables for Development Environment
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-prod-001"
}


variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "North Europe"
}


variable "db_password" {
  type      = string
  sensitive = true
}

variable "admin_username" {
  type      = string
  sensitive = true
}

variable "tls_private_key" {
  type = list(object({
    algorithm = string
    rsa_bits  = string
  }))
  default = [{
    algorithm = "RSA"
    rsa_bits  = "4096"
  }]
  sensitive = true
}

variable "db_connection_string" {
  type      = string
  default   = ""
  sensitive = true
}
