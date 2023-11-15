################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.3, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


module "budgets" {
  source  = "cloudposse/budgets/aws"
  version = "0.3.0"

  budgets = var.budgets

  notifications_enabled = var.notifications_enabled
  encryption_enabled    = var.encryption_enabled

  slack_webhook_url = var.slack_webhook_url
  slack_channel     = var.slack_channel
  slack_username    = var.slack_username

  context = module.this.context
}

