# modules/vmss-app/main.tf

resource "azurerm_linux_virtual_machine_scale_set" "vmss_app" {
  name                = var.vmss_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  count               = var.instance_count

  admin_username = var.admin_username


  sku = var.vmss_app_sku

  identity {
    type = var.identity[0].type
  }

  source_image_reference {
    publisher = var.source_image_reference[0].publisher
    offer     = var.source_image_reference[0].offer
    sku       = var.source_image_reference[0].sku
    version   = var.source_image_reference[0].version

  }


  os_disk {

    caching              = var.os_disk[0].caching
    storage_account_type = var.os_disk[0].storage_account_type


  }
  admin_ssh_key {
    username   = var.admin_ssh_key[0].username
    public_key = var.admin_ssh_key[0].public_key
  }

  network_interface {
    name    = "${var.vmss_app_name}-nic"
    primary = var.network_interface[0].ip_configuration[0].primary

    ip_configuration {
      name      = var.network_interface[0].ip_configuration[0].name
      subnet_id = var.network_interface[0].ip_configuration[0].subnet_id
      primary   = var.network_interface[0].ip_configuration[0].primary



    }

  }



  custom_data = base64encode(<<-EOF
    #!/bin/bash
    echo "App tier setup..."
   # Node.js or Python
    
  EOF
  )






  tags = {
    Owner       = var.tags["Owner"]
    environment = var.tags["environment"]
  }

}



resource "azurerm_key_vault_secret" "ssh_kv_secret" {
  name         = var.ssh_key[0].name
  value        = var.ssh_key[0].value
  key_vault_id = var.ssh_key[0].key_vault_id
}