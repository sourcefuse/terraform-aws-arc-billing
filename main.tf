################################################################################
## defaults
################################################################################
terraform {
  required_version = ">= 1.4, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
    }
  }
}


module "budgets" {
  source  = "cloudposse/budgets/aws"
  version = "0.4.1"


  budgets = var.budgets

  notifications_enabled = var.slack_notifications_enabled
  encryption_enabled    = var.encryption_enabled
  kms_master_key_id     = var.budgets_kms_master_key

  slack_webhook_url = var.slack_webhook_url
  slack_channel     = var.slack_channel
  slack_username    = var.slack_username

  context = module.this.context
}

resource "aws_sns_topic_subscription" "this" {
  for_each = var.billing_alerts_sns_subscribers

  topic_arn              = var.slack_notifications_enabled ? module.budgets.sns_topic_arn : var.sns_topic_arn
  protocol               = each.value.protocol
  endpoint               = each.value.endpoint
  endpoint_auto_confirms = each.value.endpoint_auto_confirms
  raw_message_delivery   = each.value.raw_message_delivery
}
