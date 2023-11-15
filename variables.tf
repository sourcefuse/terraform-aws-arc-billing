variable "budgets" {
  type        = any
  description = <<-EOF
  A list of Budgets to create.
  EOF
  default     = []
}

variable "notifications_enabled" {
  type        = bool
  description = "Whether or not to setup Slack notifications. Set to `true` to create an SNS topic and Lambda function to send alerts to Slack."
  default     = false
}

variable "encryption_enabled" {
  type        = bool
  description = "Whether or not to use encryption. If set to `true` and no custom value for KMS key (kms_master_key_id) is provided, a KMS key is created."
  default     = true
}

variable "slack_webhook_url" {
  type        = string
  description = "The URL of Slack webhook. Only used when `notifications_enabled` is `true`"
  default     = ""
}

variable "slack_channel" {
  type        = string
  description = "The name of the channel in Slack for notifications. Only used when `notifications_enabled` is `true`"
  default     = ""
}

variable "slack_username" {
  type        = string
  description = "The username that will appear on Slack messages. Only used when `notifications_enabled` is `true`"
  default     = ""
}