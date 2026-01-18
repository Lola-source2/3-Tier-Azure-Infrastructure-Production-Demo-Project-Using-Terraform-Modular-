# modules/network/variables.tf

variable "resource_group_name" {
  type    = string
  default = "rg-prod-001"
}

variable "location" {
  type    = string
  default = "North Europe"
}


variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "Vnet-Prod-001"
}

variable "address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]

}




variable "bastion_subnet_prefix" {
  description = " The address prefix for the bastion subnet"
  type        = list(string)
  default     = ["10.0.4.0/26"]
}

variable "bastion_subnet_name" {
  type    = string
  default = "AzureBastionSubnet"
}


variable "web_subnet_name" {
  type    = string
  default = "web-subnet"
}



variable "upgrade_policy_mode" {
  type    = string
  default = "Manual"
}

variable "web_subnet_prefix" {
  description = " The address prefix for the web subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "app_subnet_prefix" {
  description = " The address prefix for the application subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "subnet_private_endpoint" {
  description = " The address prefix for the database subnet"
  type        = list(string)
  default     = ["10.0.3.0/24"]
}


variable "internal_private_subnet" {
  type = list(object({
    name           = string
    address_prefix = list(string)
  }))
  default = [{
    name           = "internal-subnet"
    address_prefix = ["10.0.5.0/24"]
  }]

}


variable "nsg_web_name" {
  type    = string
  default = "nsg-web-001"
}

variable "nsg_app_name" {
  type    = string
  default = "nsg-app-001"
}


variable "nsg_db_name" {
  type    = string
  default = "nsg-db-001"

}

variable "nsg_web_rules_HTTP" {
  description = "The security rules for web tier NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = string
  }))

  default = [
    {
      name                       = "Allow-HTTP"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "TCP"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Allow inbound HTTP traffic on port 80"

    }

  ]
}

variable "nsg_web_rules_SSH" {
  description = "The security rules for application tier NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = string

    }


  ))
  default = [
    {
      name                       = "Allow-SSH"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "SSH"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Allow inbound SSH traffic on port 22"
    }
  ]
}



variable "nsg_app_service_tags" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = string

  }))
  default = [{
    name                       = "Allow-Vmss-web-to-App"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "10.0.2.0/24"
    description                = "Allow traffic from web tier to app tier on port 8080"
  }]

}
variable "nsg_app_rules_SSH" {
  description = "The security rules for application tier NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = string
    }


  ))
  default = [
    {
      name                       = "Allow-SSH"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "SSH"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Allow inbound SSH traffic on port 22"
  }]
}
variable "nsg_app_rules_Deny_All" {
  description = "The security rules for application tier NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = string
    }


  ))
  default = [
    {
      name                       = "Deny-All-Inbound"
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Deny all inbound traffic"
    }
  ]
}

variable "nsg_db_rules_sql" {
  description = "The security rules for database tier NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = string

  }))

  default = [
    {
      name                       = "Allow-DB-Traffic"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "SQL"
      source_port_range          = "*"
      destination_port_range     = "1433"
      source_address_prefix      = "10.0.2.0/24"
      destination_address_prefix = "10.0.3.0/24"
      description                = "Allow inbound SQL traffic on port 1433"
    }
  ]
}
variable "nsg_db_rules_Deny_All" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = string
  }))
  default = [
    {
      name                       = "Deny-All-Inbound"
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "1433"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Deny all inbound traffic"
    }
  ]
}


variable "nsg_bastion_rules_app_SSH" {
  description = "The security rules App NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = string


  }))
  default = [
    {
      name                       = "Allow-SSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "SSH"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.2.0/24"
      destination_address_prefix = "10.0.4.0/26"
      description                = "Allow inbound SSH traffic on port 22"

    }
  ]
}

variable "nsg_bastion_rules_web_SSH" {
  description = "The security rule for Bastion to web NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = string

    }
  ))

  default = [
    {
      name                       = "Allow-SSH-from_Bastion-to-web"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "SSH"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "10.0.4.0/26"
      description                = "Allow SSH traffic from Bastion to web servers"
    }
  ]

}

variable "nsg_bastion_rules_Deny_All" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = string
  }))
  default = [
    {
      name                       = "Deny-All-Inbound"
      priority                   = 4000
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "10.0.4.0/26"
      description                = "Deny all inbound traffic"
    }
  ]
}






variable "environment_tag" {
  type    = string
  default = "Prod-001"
}

variable "tags" {
  type = map(string)
  default = {
    Owner       = "CloudTeam"
    environment = "Production"
  }
}

variable "nsg_web_association" {
  type = list(object({
    subnet_id                 = list(string)
    network_security_group_id = string

  }))
  default = [{
    subnet_id                 = ["10.0.1.0/24"]
    network_security_group_id = "nsg-web-id"
  }]
}

variable "nsg_app_association" {
  type = list(object({
    subnet_id                 = list(string)
    network_security_group_id = string

  }))
  default = [{
    subnet_id                 = ["10.0.2.0/24"]
    network_security_group_id = "nsg-app-id"
  }]
}

variable "nsg_db_association" {
  type = list(object({
    subnet_id                 = list(string)
    network_security_group_id = string

  }))
  default = [{
    subnet_id                 = ["10.0.3.0/24"]
    network_security_group_id = ""
  }]
}