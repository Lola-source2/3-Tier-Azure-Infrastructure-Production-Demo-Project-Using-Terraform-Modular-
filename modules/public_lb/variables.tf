# modules/public_LB/variables.tf
variable "lb_name" {
  type    = string
  default = "lb-prod-001"
}

variable "location" {
  type    = string
  default = "North Europe"
}

variable "resource_group_name" {

  type    = string
  default = "rg-prod-001"
}

variable "frontend_ip_configurations" {
  type = list(object({
    name                 = string
    public_ip_address_id = string
  }))
  default = [{
    name                 = "lb-frontend-ip-config-001"
    public_ip_address_id = ""
  }]

}


variable "backend_web_pool" {

  type = list(object({
    name            = string
    loadbalancer_id = string
  }))
  default = [{
    name            = "be-web-pool-001"
    loadbalancer_id = "backend-ld-web-pool-001"
  }]
}




variable "probes" {
  type = list(object({
    name                = string
    loadbalancer_id     = string
    protocol            = string
    port                = number
    interval_in_seconds = number
    number_of_probes    = number
    request_path        = string
  }))
  default = [{
    name                = "lb-health-probe-001"
    loadbalancer_id     = ""
    protocol            = "HTTP"
    port                = 80
    interval_in_seconds = 15
    number_of_probes    = 2
    request_path        = "/"
  }]

}

variable "load_balancer_rules" {
  type = list(object({
    name                           = string
    loadbalancer_id                = string
    protocol                       = string
    frontend_ip_configuration_name = string

    probe_name              = string
    frontend_port           = number
    backend_port            = number
    enable_floating_ip      = bool
    idle_timeout_in_minutes = number
  }))
  default = [{
    name                           = "lb-rule-001"
    loadbalancer_id                = ""
    protocol                       = "tcp"
    frontend_ip_configuration_name = "lb-frontend-ip-config-001"

    probe_name              = "lb-health-probe-001"
    frontend_port           = 80
    backend_port            = 80
    enable_floating_ip      = false
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
    name                           = "lb-inbound-nat-pool-001"
    loadbalancer_id                = ""
    protocol                       = "Tcp"
    frontend_ip_configuration_name = "lb-frontend-ip-config-001"
    frontend_port_start            = 50000
    frontend_port_end              = 50119
    backend_port                   = 80

  }]

}



variable "lb_sku" {
  type    = string
  default = "Standard"
}











variable "tags" {
  type = map(string)
  default = {
    Owner       = "CloudTeam"
    environment = "Production"
  }
}
