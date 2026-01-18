# modules/internal_LB/variables.tf
variable "internal_lb_name" {
  type    = string
  default = "internal-lb-001"
}



variable "resource_group_name" {
  type    = string
  default = "rg-prod-001"
}

variable "internal_private_subnet_id" {
  type    = list(string)
  default = ["10.0.5.0/24"]
}





variable "location" {
  type    = string
  default = "North Europe"
}


variable "frontend_ip_configuration" {
  type = list(object({
    name                  = string
    private_ip_address_id = string
  }))
  default = [{
    name                  = "internal-lb-frontend-ipconfig"
    private_ip_address_id = "10.0.5.0/24"
  }]

}



variable "internal_probes" {
  type = list(object({
    name            = string
    loadbalancer_id = string
    protocol        = string

    port                = number
    interval_in_seconds = number
    number_of_probes    = number
    request_path        = string
  }))
  default = [{
    name                = "internal-lb-probe-001"
    loadbalancer_id     = ""
    protocol            = "HTTP"
    port                = 80
    interval_in_seconds = 15
    number_of_probes    = 2
    request_path        = "/health"
  }]

}

variable "load_balancer_rules" {
  type = list(object({
    name                           = string
    loadbalancer_id                = string
    protocol                       = string
    frontend_ip_configuration_name = string

    frontend_port           = number
    backend_port            = number
    enable_floating_ip      = bool
    probes_id               = string
    idle_timeout_in_minutes = number
  }))
  default = [{
    name                           = "internal-lb-rule-001"
    loadbalancer_id                = ""
    protocol                       = "HTTP"
    frontend_ip_configuration_name = "internal-lb-frontend-ipconfig"

    frontend_port           = 80
    backend_port            = 80
    enable_floating_ip      = false
    probes_id               = ""
    idle_timeout_in_minutes = 4
  }]

}

variable "inbound_nat_pools" {
  type = list(object({
    name                           = string
    loadbalancer_id                = string
    protocol                       = string
    frontend_ip_configuration_name = string
    frontend_port_start            = number
    frontend_port_end              = number
    backend_port                   = number


  }))
  default = [{
    name                           = "inbound-nat-pool-internal-001"
    loadbalancer_id                = ""
    protocol                       = "Tcp"
    frontend_ip_configuration_name = "internal-lb-frontend-ipconfig"
    frontend_port_start            = 5000
    frontend_port_end              = 5100
    backend_port                   = 5000
  }]

}



variable "lb_sku" {
  type    = string
  default = "Standard"
}










variable "internal_lb_backend" {

  type = list(object({
    name            = string
    loadbalancer_id = string
  }))
  default = [{
    name            = "internal-lb-backend-app-pool-001"
    loadbalancer_id = "lb-backend-app-pool-001"
  }]
}

variable "tags" {
  type = map(string)
  default = {
    Owner       = "CloudTeam"
    environment = "Production"
  }
}
