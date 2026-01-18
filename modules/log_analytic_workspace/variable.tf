# modules/log_analytic_workspace/variables.tf
variable "log_analytics_workspace" {
  type = list(object({
    name              = string
    sku               = string
    retention_in_days = number
  }))

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