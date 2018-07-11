# moj-module-metric-alert
A module that lets you create alerts in Azure based on custom log queries

## Variables

### Contextual variables

#### `resourcegroup_name`
The name of the azure resource group, such as `cmc-claim-store-prod`.

#### `app_insights_name`
The name of the application insights resource in Azure.

### Alert definition variables

#### `template_name`
The name of the template deployment. Changing this forces a new resource to be created. Must match the format `^[-\w\._\(\)]+$`.

#### `alert_name`
The name of the alert to create.

#### `alert_desc`
A description of the alert.

#### `app_insights_query`
The custom query to execute against the logs. See https://docs.microsoft.com/en-us/azure/application-insights/app-insights-analytics .

#### `frequency_in_minutes`
(Optional)
(Default = 5)
The number of minutes between inspections. That is, a value of `5` means the alert will be queried every 5 minutes, for a frequency of 12/minute.

#### `time_window_in_minutes`
(Optional)
(Default = 5)
The previous window of time over which to execute the query, in minutes. This is often the same value as `frequency_in_minutes`.

#### `severity_level`
(Optional)
(Default = 3)
The severity of this alert. Allowed values are from `0` to `4`, with `3` being the default.

#### `action_group_name`
The name of the action group to invoke when the alert is triggered.

#### `trigger_threshold_operator`
(Optional)
(Default = GreaterThan)
The operator to apply to the result with respect to the `trigger_threshold`. Allowed values are:
        "`GreaterThan`",
        "`Equal`", and 
        "`LessThan`".

#### `trigger_threshold`
The threshold at which to trigger the alert, with respect to the `trigger_threshold_operator`.
