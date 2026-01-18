# modules/network/main.tf

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }

}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = var.bastion_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.bastion_subnet_prefix


}


resource "azurerm_subnet" "web-subnet" {
  name                 = var.web_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web_subnet_prefix


}

resource "azurerm_subnet" "app-subnet" {
  name                 = "app-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app_subnet_prefix


}

resource "azurerm_subnet" "internal_subnet" {
  name                 = var.internal_private_subnet[0].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.internal_private_subnet[0].address_prefix



}


resource "azurerm_subnet" "private_subnet" {
  name                 = "subnet-private-endpoint"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_private_endpoint

}








resource "azurerm_network_security_group" "nsg_web_rules_HTTP" {
  name                = var.nsg_web_rules_HTTP[0].name
  location            = var.location
  resource_group_name = var.resource_group_name


  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }

  security_rule {
    name                       = var.nsg_web_rules_HTTP[0].name
    priority                   = var.nsg_web_rules_HTTP[0].priority
    direction                  = var.nsg_web_rules_HTTP[0].direction
    access                     = var.nsg_web_rules_HTTP[0].access
    protocol                   = var.nsg_web_rules_HTTP[0].protocol
    source_port_range          = var.nsg_web_rules_HTTP[0].source_port_range
    destination_port_range     = var.nsg_web_rules_HTTP[0].destination_port_range
    source_address_prefix      = var.nsg_web_rules_HTTP[0].source_address_prefix
    destination_address_prefix = var.nsg_web_rules_HTTP[0].destination_address_prefix
    description                = var.nsg_web_rules_HTTP[0].description

  }
}


resource "azurerm_network_security_group" "nsg_web_rules_SSH" {
  name                = var.nsg_web_rules_SSH[0].name
  location            = var.location
  resource_group_name = var.resource_group_name


  security_rule {

    name                       = var.nsg_web_rules_SSH[0].name
    priority                   = var.nsg_web_rules_SSH[0].priority
    direction                  = var.nsg_web_rules_SSH[0].direction
    access                     = var.nsg_web_rules_SSH[0].access
    protocol                   = var.nsg_web_rules_SSH[0].protocol
    source_port_range          = var.nsg_web_rules_SSH[0].source_port_range
    destination_port_range     = var.nsg_web_rules_SSH[0].destination_port_range
    source_address_prefix      = var.nsg_web_rules_SSH[0].source_address_prefix
    destination_address_prefix = var.nsg_web_rules_SSH[0].destination_address_prefix
    description                = var.nsg_web_rules_SSH[0].description
  }

}


resource "azurerm_network_security_group" "nsg_app_service_tags" {
  name                = var.nsg_app_service_tags[0].name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {

    name                       = var.nsg_app_service_tags[0].name
    priority                   = var.nsg_app_service_tags[0].priority
    direction                  = var.nsg_app_service_tags[0].direction
    access                     = var.nsg_app_service_tags[0].access
    protocol                   = var.nsg_app_service_tags[0].protocol
    source_port_range          = var.nsg_app_service_tags[0].source_port_range
    destination_port_range     = var.nsg_app_service_tags[0].destination_port_range
    source_address_prefix      = var.nsg_app_service_tags[0].source_address_prefix
    destination_address_prefix = var.nsg_app_service_tags[0].destination_address_prefix
    description                = var.nsg_app_service_tags[0].description
  }
}




resource "azurerm_network_security_group" "nsg_app_rules_SSH" {
  name                = var.nsg_app_rules_SSH[0].name
  location            = var.location
  resource_group_name = var.resource_group_name


  security_rule {

    name                       = var.nsg_app_rules_SSH[0].name
    priority                   = var.nsg_app_rules_SSH[0].priority
    direction                  = var.nsg_app_rules_SSH[0].direction
    access                     = var.nsg_app_rules_SSH[0].access
    protocol                   = var.nsg_app_rules_SSH[0].protocol
    source_port_range          = var.nsg_app_rules_SSH[0].source_port_range
    destination_port_range     = var.nsg_app_rules_SSH[0].destination_port_range
    source_address_prefix      = var.nsg_app_rules_SSH[0].source_address_prefix
    destination_address_prefix = var.nsg_app_rules_SSH[0].destination_address_prefix

  }
}

resource "azurerm_network_security_group" "nsg_app_rules_Deny_All" {
  name                = var.nsg_app_rules_Deny_All[0].name
  location            = var.location
  resource_group_name = var.resource_group_name


  security_rule {
    name                       = var.nsg_app_rules_Deny_All[0].name
    priority                   = var.nsg_app_rules_Deny_All[0].priority
    direction                  = var.nsg_app_rules_Deny_All[0].direction
    access                     = var.nsg_app_rules_Deny_All[0].access
    protocol                   = var.nsg_app_rules_Deny_All[0].protocol
    source_port_range          = var.nsg_app_rules_Deny_All[0].source_port_range
    destination_port_range     = var.nsg_app_rules_Deny_All[0].destination_port_range
    source_address_prefix      = var.nsg_app_rules_Deny_All[0].source_address_prefix
    destination_address_prefix = var.nsg_app_rules_Deny_All[0].destination_address_prefix
    description                = var.nsg_app_rules_Deny_All[0].description


  }




  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }

}

resource "azurerm_network_security_group" "nsg_bastion_rules_web_SSH" {
  name                = var.nsg_bastion_rules_web_SSH[0].name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {

    name                       = var.nsg_bastion_rules_web_SSH[0].name
    priority                   = var.nsg_bastion_rules_web_SSH[0].priority
    direction                  = var.nsg_bastion_rules_web_SSH[0].direction
    access                     = var.nsg_bastion_rules_web_SSH[0].access
    protocol                   = var.nsg_bastion_rules_web_SSH[0].protocol
    source_port_range          = var.nsg_bastion_rules_web_SSH[0].source_port_range
    destination_port_range     = var.nsg_bastion_rules_web_SSH[0].destination_port_range
    source_address_prefix      = var.nsg_bastion_rules_web_SSH[0].source_address_prefix
    destination_address_prefix = var.nsg_bastion_rules_web_SSH[0].destination_address_prefix
    description                = var.nsg_bastion_rules_web_SSH[0].description
  }
}

resource "azurerm_network_security_group" "nsg_bastion_rules_app_SSH" {
  name                = var.nsg_bastion_rules_app_SSH[0].name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {

    name                       = var.nsg_bastion_rules_app_SSH[0].name
    priority                   = var.nsg_bastion_rules_app_SSH[0].priority
    direction                  = var.nsg_bastion_rules_app_SSH[0].direction
    access                     = var.nsg_bastion_rules_app_SSH[0].access
    protocol                   = var.nsg_bastion_rules_app_SSH[0].protocol
    source_port_range          = var.nsg_bastion_rules_app_SSH[0].source_port_range
    destination_port_range     = var.nsg_bastion_rules_app_SSH[0].destination_port_range
    source_address_prefix      = var.nsg_bastion_rules_app_SSH[0].source_address_prefix
    destination_address_prefix = var.nsg_bastion_rules_app_SSH[0].destination_address_prefix
    description                = var.nsg_bastion_rules_app_SSH[0].description
  }
}


resource "azurerm_network_security_group" "nsg_bastion_rules_Deny_All" {
  name                = var.nsg_bastion_rules_Deny_All[0].name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {

    name                       = var.nsg_bastion_rules_Deny_All[0].name
    priority                   = var.nsg_bastion_rules_Deny_All[0].priority
    direction                  = var.nsg_bastion_rules_Deny_All[0].direction
    access                     = var.nsg_bastion_rules_Deny_All[0].access
    protocol                   = var.nsg_bastion_rules_Deny_All[0].protocol
    source_port_range          = var.nsg_bastion_rules_Deny_All[0].source_port_range
    destination_port_range     = var.nsg_bastion_rules_Deny_All[0].destination_port_range
    source_address_prefix      = var.nsg_bastion_rules_Deny_All[0].source_address_prefix
    destination_address_prefix = var.nsg_bastion_rules_Deny_All[0].destination_address_prefix
    description                = var.nsg_bastion_rules_Deny_All[0].description
  }
}


resource "azurerm_network_security_group" "nsg_db_rules_sql" {
  name                = var.nsg_db_rules_sql[0].name
  location            = var.location
  resource_group_name = var.resource_group_name


  security_rule {
    name                       = var.nsg_db_rules_sql[0].name
    priority                   = var.nsg_db_rules_sql[0].priority
    direction                  = var.nsg_db_rules_sql[0].direction
    access                     = var.nsg_db_rules_sql[0].access
    protocol                   = var.nsg_db_rules_sql[0].protocol
    source_port_range          = var.nsg_db_rules_sql[0].source_port_range
    destination_port_range     = var.nsg_db_rules_sql[0].destination_port_range
    source_address_prefix      = var.nsg_db_rules_sql[0].source_address_prefix
    destination_address_prefix = var.nsg_db_rules_sql[0].destination_address_prefix
    description                = var.nsg_db_rules_sql[0].description

  }





  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }

}


resource "azurerm_network_security_group" "nsg_db_rules_Deny_All" {
  name                = var.nsg_db_rules_Deny_All[0].name
  location            = var.location
  resource_group_name = var.resource_group_name


  security_rule {
    name                       = var.nsg_db_rules_Deny_All[0].name
    priority                   = var.nsg_db_rules_Deny_All[0].priority
    direction                  = var.nsg_db_rules_Deny_All[0].direction
    access                     = var.nsg_db_rules_Deny_All[0].access
    protocol                   = var.nsg_db_rules_Deny_All[0].protocol
    source_port_range          = var.nsg_db_rules_Deny_All[0].source_port_range
    destination_port_range     = var.nsg_db_rules_Deny_All[0].destination_port_range
    source_address_prefix      = var.nsg_db_rules_Deny_All[0].source_address_prefix
    destination_address_prefix = var.nsg_db_rules_Deny_All[0].destination_address_prefix
    description                = var.nsg_db_rules_Deny_All[0].description


  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_web_http_association" {

  subnet_id                 = azurerm_subnet.web-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_web_rules_HTTP.id

}

resource "azurerm_subnet_network_security_group_association" "nsg_web_ssh_association" {

  subnet_id                 = azurerm_subnet.web-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_web_rules_SSH.id

}

resource "azurerm_subnet_network_security_group_association" "nsg_app_service_tags_association" {

  subnet_id                 = azurerm_subnet.app-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_app_service_tags.id

}

resource "azurerm_subnet_network_security_group_association" "nsg_app_ssh_association" {

  subnet_id                 = azurerm_subnet.app-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_app_rules_SSH.id

}

resource "azurerm_subnet_network_security_group_association" "nsg_app_deny_all_association" {

  subnet_id                 = azurerm_subnet.app-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_app_rules_Deny_All.id

}

resource "azurerm_subnet_network_security_group_association" "nsg_db_sql_association" {

  subnet_id                 = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_db_rules_sql.id

}

resource "azurerm_subnet_network_security_group_association" "nsg_db_deny_all_association" {

  subnet_id                 = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_db_rules_Deny_All.id

}

resource "azurerm_subnet_network_security_group_association" "nsg_bastion_web_ssh_association" {

  subnet_id                 = azurerm_subnet.web-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_bastion_rules_web_SSH.id

}


resource "azurerm_subnet_network_security_group_association" "nsg_bastion_app_ssh_association" {

  subnet_id                 = azurerm_subnet.app-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_bastion_rules_app_SSH.id

}

resource "azurerm_subnet_network_security_group_association" "nsg_bastion_deny_all_association" {

  subnet_id                 = azurerm_subnet.bastion_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_bastion_rules_Deny_All.id

}