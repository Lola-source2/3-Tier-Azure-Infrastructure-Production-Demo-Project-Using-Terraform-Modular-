# modules/bastion_public_ip/variables.tf

variable "public_ip_bastion" {
  type = list(object({
    name              = string
    sku               = string
    allocation_method = string
  }))
  default = [{
    name              = "pip-bastion-001"
    sku               = "Standard"
    allocation_method = "Static"
  }]
}


variable "resource_group_name" {
  type    = string
  default = "rg-prod-001"
}

variable "location" {
  type    = string
  default = "North Europe"
}

variable "tags" {
  type = map(string)
  default = {
    Owner       = "CloudTeam"
    environment = "Production"
  }
}