variable resourcegroup_name {
  description = "The name of the azure resource group"
}

variable app_insights_name {
  description = "The name of the application insights resource in Azure"
}

variable location {
  description = "The location of the Azure data center"
}

variable alert_name {
  description = "The name of the alert to create"
}

variable alert_desc {
  description = "A description of the alert"
}

variable app_insights_query {
  description = "The custom query to execute against the logs"
}

variable frequency_in_minutes {
  description = "The number of minutes between inspections"
  default     = "5"
}

variable time_window_in_minutes {
  description = "The previous window of time over which to execute the query, in minutes"
  default     = "5"
}

variable severity_level {
  description = "The severity of this alert, from 0 to 4 inclusive"
  default     = "3"
}

variable action_group_name {
  description = "The name of the action group to invoke when the alert is triggered"
}

variable "action_group_rg" {
  description = "The resource group the action group resides in, useful if you have a shared action group"
  default     = ""
}

variable custom_email_subject {
  description = "The subject of the email sent to the email IDs specified in the action group"
}

variable trigger_threshold_operator {
  description = "The operator to apply to the result with respect to the trigger_threshold. Allowed values are: GreaterThan, Equal and LessThan."
  default     = "GreaterThan"
}

variable trigger_threshold {
  description = "The threshold at which to trigger the alert, with respect to the trigger_threshold_operator"
}

variable "enabled" {
  description = "Whether alert is created or not"
  default = "true"
}
