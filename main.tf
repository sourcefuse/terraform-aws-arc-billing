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

# ###### painful testing
# resource "aws_sns_topic_policy" "budgets" {

#   arn    = aws_sns_topic.budgets.arn
#   policy = data.aws_iam_policy_document.aws_sns_topic_policy.json
# }

# data "aws_iam_policy_document" "aws_sns_topic_policy" {
#   policy_id = "BudgetsSNSTopicsPub"
#   statement {
#     effect    = "Allow"
#     actions   = ["sns:Publish"]
#     resources = [aws_sns_topic.budgets.arn]

#     principals {
#       type        = "Service"
#       identifiers = ["budgets.amazonaws.com"]
#     }
#   }
# }


# resource "aws_sns_topic" "budgets" {
#   name = "${var.namespace}-${var.environment}-budget-sns"
# }

# resource "aws_budgets_budget" "ec2" {
#   name              = "${var.namespace}-${var.environment}-budget-daily"
#   budget_type       = "COST"
#   limit_amount      = "1"
#   limit_unit        = "USD"
#   time_period_start = "2023-11-21_00:00"
#   time_unit         = "DAILY"

#   cost_types {
#     include_other_subscription = true
#     include_recurring          = true
#     include_subscription       = true
#     include_support            = true
#     include_tax                = true
#     include_upfront            = true
#     include_discount           = true
#     include_credit             = false
#     include_refund             = false
#     use_blended                = false
#     use_amortized              = false
#   }

#   # cost_filter {
#   #   name = "Service"
#   #   values = [
#   #     "Amazon Elastic Compute Cloud - Compute",
#   #   ]
#   # }

#   notification {
#     comparison_operator        = "GREATER_THAN"
#     threshold                  = 100
#     threshold_type             = "PERCENTAGE"
#     notification_type          = "ACTUAL"
#     subscriber_email_addresses = ["hernandez.anyiabey@sourcefuse.com"]
#     subscriber_sns_topic_arns  = [aws_sns_topic_subscription.email_subscription[0].id]
#   }
# }




