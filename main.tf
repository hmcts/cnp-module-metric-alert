
data "template_file" "metricalerttemplate" {
  template = "${file("${path.module}/templates/Alert.json")}"
}

resource "azurerm_template_deployment" "custom_alert" {
  template_body       = "${data.template_file.metricalerttemplate.rendered}"
  name                = "${var.template_name}"
  resource_group_name = "${var.resourcegroup_name}"
  deployment_mode     = "Incremental"

  parameters = {
    alertName                = "${var.alert_name}"
    alertDesc                = "${var.alert_desc}"
    appInsightsName          = "${var.app_insights_name}"
    triggerThresholdOperator = "${var.trigger_threshold_operator}"
    triggerThreshold         = "${var.trigger_threshold + 0}"
    frequencyInMinutes       = "${var.frequency_in_minutes + 0}"
    timeWindowInMinutes      = "${var.time_window_in_minutes + 0}"
    severityLevel            = "${var.severity_level}"
    actionGroupName          = "${var.action_group_name}"
    appInsightsQuery         = "${var.app_insights_query}"
  }
}
