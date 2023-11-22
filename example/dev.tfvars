region      = "us-east-1"
namespace   = "arc"
environment = "dev"

budgets = [
  {
    name            = "ec2-daily-budget-1000"
    budget_type     = "COST"
    limit_amount    = "0.30"
    limit_unit      = "USD"
    time_period_start = "2023-11-21_00:00"
    time_unit       = "DAILY"

    cost_filter = {
      Service = ["Amazon Elastic Compute Cloud - Compute"]
    }

    cost_types = {
      include_discount           = true
      include_other_subscription = true
      include_recurring          = true
      include_subscription       = true
      include_tax                = true
      include_upfront            = true
      include_support            = true
      include_refund             = false
      include_credit             = false
      use_blended                = false
    }

    notification = {
      comparison_operator = "GREATER_THAN"
      threshold           = "100"
      threshold_type      = "PERCENTAGE"
      notification_type   = "ACTUAL"
      subscriber_email_addresses = ["hernandez.anyiabey@sourcefuse.com"]
    }
  },
  {
    name         = "total-daily-2500"
    budget_type  = "COST"
    limit_amount = "1"
    time_period_start = "2023-11-21_00:00"
    limit_unit   = "USD"
    time_unit    = "DAILY"

    cost_types = {
      include_discount           = true
      include_other_subscription = true
      include_recurring          = true
      include_subscription       = true
      include_tax                = true
      include_upfront            = true
      include_support            = true
      include_refund             = false
      include_credit             = false
      use_blended                = false
    }

    notification = {
      comparison_operator = "GREATER_THAN"
      threshold           = "100"
      threshold_type      = "PERCENTAGE"
      notification_type   = "ACTUAL"
      subscriber_email_addresses = ["hernandez.anyiabey@sourcefuse.com"]
    }
  }
]

encryption_enabled    = true
notifications_enabled = true
slack_webhook_url     = "https://hooks.slack.com/services/AAAAAAAA/BBBBBBBB/CCCCCCC"
slack_channel         = "aws-budget-alerts"
slack_username        = "slack_sa"

billing_notification_emails = ["hernandez.anyiabey@sourcefuse.com"]