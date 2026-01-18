# modules/lb-public-ip/variables.tf
variable "public_ip_lb" {
  type = list(object({
    name              = string
    allocation_method = string
    sku               = string
  }))

  default = [{
    name              = "pip-lb-001"
    allocation_method = "Static"
    sku               = "Standard"
  }]
}

variable "tags" {
  type = map(string)
  default = {
    Owner       = "CloudTeam"
    environment = "Production"
  }
}

variable "resource_group_name" {
  type    = string
  default = "rg-prod-001"
}

variable "location" {
  type    = string
  default = "North Europe"
}