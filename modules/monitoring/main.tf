
# modules/monitoring/main.tf

resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic" {
  name = var.monitor_diagnostic_setting[0].name

  target_resource_id         = var.monitor_diagnostic_setting[0].target_resource_id
  log_analytics_workspace_id = var.monitor_diagnostic_setting[0].log_analytics_workspace_id


  enabled_log {
    category = var.monitor_diagnostic_setting[0].enabled_logs[0].category

  }

  enabled_metric {
    category = var.monitor_diagnostic_setting[0].enabled_metrics[0].category

  }
}

resource "azurerm_monitor_metric_alert" "metric_alert" {

  resource_group_name = var.resource_group_name
  description         = var.monitor_metric_alert[0].description
  name                = var.monitor_metric_alert[0].name
  severity            = var.monitor_metric_alert[0].severity
  enabled             = var.monitor_metric_alert[0].enabled

  window_size = var.monitor_metric_alert[0].window_size

  scopes = [var.vmss_web_id, var.vmss_app_id]


  criteria {
    threshold        = var.monitor_metric_alert[0].critical[0].threshold
    operator         = var.monitor_metric_alert[0].critical[0].operator
    aggregation      = var.monitor_metric_alert[0].critical[0].aggregation
    metric_namespace = var.monitor_metric_alert[0].critical[0].metric_namespace
    metric_name      = var.monitor_metric_alert[0].critical[0].metric_name
  }


}


resource "azurerm_monitor_action_group" "action_group" {
  name                = var.monitor_action_group[0].name
  resource_group_name = var.resource_group_name
  short_name          = var.monitor_action_group[0].short_name


  email_receiver {
    name                    = var.monitor_action_group[0].email_receiver[0].name
    email_address           = var.monitor_action_group[0].email_receiver[0].email_address
    use_common_alert_schema = var.monitor_action_group[0].email_receiver[0].use_common_alert_schema
  }


}