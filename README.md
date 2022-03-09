# moj-module-metric-alert
A module that lets you create alerts in Azure based on custom log queries. Refer to the following link for a detailed explanation of the approach taken.

[Setting up Alerts using Application Insights (the new ones)](http://chapsas.com/setting-up-alerts-using-application-insights-the-new-ones/)

## Variables

### Configuration

The following parameters are required by this module

- `resourcegroup_name` The name of the azure resource group, such as `cmc-claim-store-prod`.
- `app_insights_name` The name of the application insights resource in Azure.
- `location` The location of the Azure data center.
- `alert_name` The name of the alert to create.
- `alert_desc` A description of the alert.
- `app_insights_query` The custom query to execute against the logs. See https://docs.microsoft.com/en-us/azure/application-insights/app-insights-analytics .
- `action_group_name` The name of the action group to invoke when the alert is triggered.
- `custom_email_subject` The subject of the email sent to the email IDs specified in the action group. (If there are no email IDs in the action group, this must still be defined but can be set to the empty string.)
- `trigger_threshold` The threshold at which to trigger the alert, with respect to the `trigger_threshold_operator`.

The following parameters are optional

- `enabled` true/false flag. Default is true
- `frequency_in_minutes` The number of minutes between inspections. That is, a value of `5` means the alert will be queried every 5 minutes, for a frequency of 12/minute. Default is `5`.
- `time_window_in_minutes` The previous window of time over which to execute the query, in minutes. This is often the same value as `frequency_in_minutes`. Default is `5`.
- `severity_level` The severity of this alert. Allowed values are from `0` to `4`. Default is `3`.
- `trigger_threshold_operator` The operator to apply to the result with respect to the `trigger_threshold`. Allowed values are:
        "`GreaterThan`",
        "`Equal`", and 
        "`LessThan`". Default is `GreaterThan`.

### Output

This module provides no outputs.

## Usage

The following example shows how to use the module to create an (enabled) Azure alert for an application insights instance.

```terraform
module "messy-dudes-alert" {
  source = "git@github.com:hmcts/cnp-module-metric-alert"
  location = "${var.appinsights_location}"

  app_insights_name = "my-app-insights"

  alert_name = "Dudes Messed Up Alert"
  alert_desc = "Triggers when too many dudes mess up in a 5 minute poll."
  app_insights_query = "customEvents | where name == \"Dude messed up\""
  custom_email_subject = "Warning: Dudes Messed Up Alert"
  frequency_in_minutes = 5
  time_window_in_minutes = 5
  severity_level = "2"
  action_group_name = "Dudes messing up alert recipients"
  trigger_threshold_operator = "GreaterThan"
  trigger_threshold = 42
  resourcegroup_name = "my_resource_group"
}
```
