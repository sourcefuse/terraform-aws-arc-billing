region      = "us-east-1"
namespace   = "arc"
environment = "dev"

budgets = [
  {
    name            = "ec2-monthly-budget-1000"
    budget_type     = "COST"
    limit_amount    = "500"
    limit_unit      = "USD"
    time_period_end = "2025-06-15_00:00"
    time_unit       = "MONTHLY"

    cost_filter = {
      Service = ["Amazon Elastic Compute Cloud - Compute"]
    }

    cost_types = {
      include_credit             = true
      include_discount           = true
      include_other_subscription = false
      include_recurring          = true
      include_refund             = true
      include_subscription       = true
      include_support            = false
      include_tax                = true
      include_upfront            = true
      use_blended                = false
    }

    notification = {
      comparison_operator = "GREATER_THAN"
      threshold           = "100"
      threshold_type      = "PERCENTAGE"
      notification_type   = "FORECASTED"
    }
  },
  {
    name         = "total-monthly-2500"
    budget_type  = "COST"
    limit_amount = "2500"
    limit_unit   = "USD"
    time_unit    = "MONTHLY"

    notification = {
      comparison_operator = "GREATER_THAN"
      threshold           = "100"
      threshold_type      = "PERCENTAGE"
      notification_type   = "FORECASTED"
    }
  }
]

encryption_enabled    = true
notifications_enabled = true
slack_webhook_url     = "https://hooks.slack.com/services/AAAAAAAA/BBBBBBBB/CCCCCCC"
slack_channel         = "aws-budget-alerts"
slack_username        = "slack_sa"

billing_notification_emails = ["hernandez.anyiabey@sourcefuse.com"]