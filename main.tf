locals {
  action_group_rg = "${var.action_group_rg != "" ? var.action_group_rg : var.resourcegroup_name}"
}

data "template_file" "metricalerttemplate" {
  template = "${file("${path.module}/templates/Alert.json")}"
}

resource "azurerm_resource_group_template_deployment" "custom_alert" {
  count               = "${var.enabled ? 1 : 0}"
  template_content       = "${data.template_file.metricalerttemplate.rendered}"
  name                = "${var.alert_name}"
  resource_group_name = "${var.resourcegroup_name}"
  deployment_mode     = "Incremental"

  parameters_content = jsonencode({
    alertName                = "${var.alert_name}"
    alertDesc                = "${var.alert_desc}"
    appInsightsName          = "${var.app_insights_name}"
    location                 = "${var.location}"
    triggerThresholdOperator = "${var.trigger_threshold_operator}"
    triggerThreshold         = "${var.trigger_threshold}"
    frequencyInMinutes       = "${var.frequency_in_minutes}"
    timeWindowInMinutes      = "${var.time_window_in_minutes}"
    severityLevel            = "${var.severity_level}"
    actionGroupName          = "${var.action_group_name}"
    customEmailSubject       = "${var.custom_email_subject}"
    appInsightsQuery         = "${var.app_insights_query}"
    actionGroupRg            = "${local.action_group_rg}"
    commonTags               = base64encode(var.common_tags)
  })
}
