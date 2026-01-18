# modules/vmss-app/variables.tf
variable "vmss_app_name" {
  type    = string
  default = "vmss-app-001"
}

variable "vmss_app_instance_count" {
  type    = number
  default = 2
}

variable "vmss_app_sku" {
  type    = string
  default = "Standard_B1s"

}



variable "resource_group_name" {
  type    = string
  default = "rg-prod-001"
}

variable "source_image_reference" {
  type = list(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))
  default = [{
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }]
}




variable "app_subnet_id" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}

variable "location" {
  type    = string
  default = "North Europe"
}



variable "network_interface" {
  type = list(object({
    name    = string
    primary = bool
    ip_configuration = list(object({
      name      = string
      subnet_id = string
      primary   = bool

    }))
  }))
  default = [{
    name    = "vmss app nic"
    primary = true
    ip_configuration = [{
      name      = "vmss app ipconfig"
      subnet_id = ""
      primary   = true

    }]

  }]
}



variable "admin_username" {
  type    = string
  default = ""
}

variable "os_disk" {
  type = list(object({

    caching              = string
    storage_account_type = string
  }))
  default = [{

    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }]
}


variable "admin_ssh_key" {
  type = list(object({
    username   = string
    public_key = string

  }))
}


variable "identity" {
  type = list(object({
    type = string
  }))
  default = [{
    type = "SystemAssigned"
  }]
}


variable "instance_count" {
  type    = number
  default = 2
}



variable "db_name" {
  type    = string
  default = "sqldb-prod-001"
}





variable "tags" {
  type = map(string)
  default = {
    Owner       = "CloudTeam"
    environment = "Production"
  }
}


variable "ssh_key" {
  type = list(object({
    name         = string
    value        = string
    key_vault_id = string

  }))

}

