# modules/monitoring/variables.tf

variable "resource_group_name" {
  type    = string
  default = "rg-prod-001"
}

variable "location" {
  type    = string
  default = "North Europe"
}



variable "monitor_diagnostic_setting" {
  type = list(object({
    name                       = string
    target_resource_id         = string
    log_analytics_workspace_id = string
    enabled_logs = list(object({
      category = string

    }))
    enabled_metrics = list(object({
      category = string

    }))
  }))

  default = [{
    name                       = "monitor-diagnostic-setting-001"
    target_resource_id         = ""
    log_analytics_workspace_id = ""
    enabled_logs = [{
      category = "SQLSecurityAuditEvents"

    }]
    enabled_metrics = [{
      category = "AllMetrics"

    }]
  }]
}






variable "monitor_metric_alert" {
  type = list(object({
    name = string

    severity    = number
    description = string
    enabled     = bool
    scopes      = list(string)

    window_size = string

    critical = list(object({
      threshold        = number
      operator         = string
      aggregation      = string
      metric_namespace = string
      metric_name      = string

    }))
  }))
  default = [{
    name        = "metric-alert-cpu-001"
    severity    = 3
    description = "CPU Utilization Alert"
    enabled     = true
    scopes      = [""]

    window_size = "PT5M"
    critical = [{
      threshold        = 80
      operator         = "GreaterThan"
      aggregation      = "Average"
      metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
      metric_name      = "Percentage CPU"
    }]
  }]

}

variable "sql_server_id" {
  type    = string
  default = ""
}

variable "vmss_web_id" {
  type    = string
  default = ""
}

variable "vmss_app_id" {
  type    = string
  default = ""
}



variable "monitor_action_group" {
  type = list(object({
    name       = string
    short_name = string
    email_receiver = list(object({
      name                    = string
      email_address           = string
      use_common_alert_schema = bool
    }))
  }))
  default = [{
    name       = "action-group-001"
    short_name = "ag001"
    email_receiver = [{
      name                    = "email-receiver-001"
      email_address           = "oomowon@outlook.com"
      use_common_alert_schema = true
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