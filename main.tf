################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


module "budgets" {
  source  = "cloudposse/budgets/aws"
  version = "0.3.0"

  budgets = var.budgets

  notifications_enabled = var.notifications_enabled
  encryption_enabled    = var.encryption_enabled
  kms_master_key_id = var.budgets_kms_master_key

  slack_webhook_url = var.slack_webhook_url
  slack_channel     = var.slack_channel
  slack_username    = var.slack_username

  context = module.this.context
}


resource "aws_sns_topic_subscription" "email_subscription" {
  count     = length(var.billing_notification_emails)
  topic_arn = module.budgets.sns_topic_arn
  protocol  = "email"
  endpoint  = var.billing_notification_emails[count.index]
}


