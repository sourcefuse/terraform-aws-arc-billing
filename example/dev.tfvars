region      = "us-east-1"
namespace   = "arc"
environment = "dev"

budgets = [
  {
    name            = "ec2-monthly-budget-50"
    budget_type     = "COST"
    limit_amount    = "50"
    limit_unit      = "USD"
    time_period_end = "2025-06-15_00:00"
    time_unit       = "MONTHLY"

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
      comparison_operator        = "GREATER_THAN"
      threshold                  = "100"
      threshold_type             = "PERCENTAGE"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = ["example@sourcefuse.com"]
    }
  },
  {
    name         = "total-monthly-100"
    budget_type  = "COST"
    limit_amount = "100"
    limit_unit   = "USD"
    time_unit    = "MONTHLY"

    notification = {
      comparison_operator        = "GREATER_THAN"
      threshold                  = "100"
      threshold_type             = "PERCENTAGE"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = ["example@sourcefuse.com"]
    }
  }
]

encryption_enabled    = true
notifications_enabled = true
slack_webhook_url     = null
slack_channel         = null
slack_username        = null

billing_notification_emails = ["vijay.stephen@sourcefuse.com"]

billing_alerts_sns_subscribers = {
  "email" = {
    protocol               = "email"
    endpoint               = "vijay.stephen@sourcefuse.com"
    endpoint_auto_confirms = true
    raw_message_delivery   = false
  }
}