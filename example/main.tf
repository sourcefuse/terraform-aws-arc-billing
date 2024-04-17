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

module "tags" {
  source  = "sourcefuse/arc-tags/aws"
  version = "1.2.3"

  environment = var.environment
  project     = var.project

  extra_tags = {
    Repo         = "github.com/sourcefuse/terraform-aws-arc-billing"
    MonoRepo     = "True"
    MonoRepoPath = "terraform/billing"
  }
}


provider "aws" {
  region = var.region
}

module "example_budgets" {
  source  = "sourcefuse/arc-billing/aws"
  version = "1.0.6"

  namespace   = var.namespace
  environment = var.environment

  budgets = var.budgets

  slack_notifications_enabled = var.notifications_enabled
  encryption_enabled          = var.encryption_enabled

  slack_webhook_url = var.slack_webhook_url
  slack_channel     = var.slack_channel
  slack_username    = var.slack_username

  // sns_topic_arn = module.sns.sns_topic_arn --> This is mandatory if slack_notifications_enabled is false

  billing_alerts_sns_subscribers = var.billing_alerts_sns_subscribers

}
