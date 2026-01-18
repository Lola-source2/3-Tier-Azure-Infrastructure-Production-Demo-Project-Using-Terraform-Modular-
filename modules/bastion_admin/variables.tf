# # modules/bastion_admin/variables.tf
variable "resource_group_name" {
  type    = string
  default = "rg-prod-001"
}

variable "location" {
  type    = string
  default = "North Europe"
}


variable "bastion_host" {
  type = list(object({
    name = string
    sku  = string

    ip_configuration = list(object({
      name                 = string
      subnet_id            = list(string)
      public_ip_address_id = string
    }))
  }))

  default = [{
    name = "bastion-host-001"
    sku  = "Standard"
    ip_configuration = [{
      name                 = "bastion-ip-config-001"
      subnet_id            = [""]
      public_ip_address_id = ""
    }]
  }]


}


variable "tags" {
  type = map(string)
  default = {
    Owner       = "CloudTeam"
    environment = "Production"
  }
}