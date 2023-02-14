locals {
  action_group_rg = var.action_group_rg != "" ? var.action_group_rg : var.resourcegroup_name
}

data "template_file" "metricalerttemplate" {
  template = file("${path.module}/templates/Alert.json")
}

resource "azurerm_resource_group_template_deployment" "custom_alert" {
  count               = var.enabled ? 1 : 0
  template_content    = data.template_file.metricalerttemplate.rendered
  name                = var.alert_name
  resource_group_name = var.resourcegroup_name
  deployment_mode     = "Incremental"

  parameters_content = jsonencode({
    alertName                = { value = var.alert_name }
    alertDesc                = { value = var.alert_desc }
    appInsightsName          = { value = var.app_insights_name }
    location                 = { value = var.location }
    triggerThresholdOperator = { value = var.trigger_threshold_operator }
    triggerThreshold         = { value = var.trigger_threshold }
    frequencyInMinutes       = { value = var.frequency_in_minutes }
    timeWindowInMinutes      = { value = var.time_window_in_minutes }
    severityLevel            = { value = var.severity_level }
    actionGroupName          = { value = var.action_group_name }
    customEmailSubject       = { value = var.custom_email_subject }
    appInsightsQuery         = { value = var.app_insights_query }
    actionGroupRg            = { value = local.action_group_rg }
    commonTags               = { value = base64encode(jsonencode(var.common_tags))}
  })
}
