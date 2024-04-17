# SNS topic will be created when var.slack_notifications_enabled is false
# If true CP module will create the SNS topic

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kms" {
  count = var.slack_notifications_enabled == false ? 1 : 0

  statement {
    sid    = "Allow the account identity to manage the KMS key"
    effect = "Allow"

    actions = [
      "kms:*"
    ]

    resources = [
      "*"
    ]

    principals {
      type = "AWS"

      identifiers = [
        format("arn:aws:iam::%s:root", join("", data.aws_caller_identity.current.account_id))
      ]
    }
  }

  statement {
    sid    = "Allow Budgets to use key for notifications"
    effect = "Allow"

    actions = [
      "kms:GenerateDataKey*",
      "kms:Decrypt"
    ]

    resources = ["*"]

    principals {
      type = "Service"

      identifiers = [
        "budgets.amazonaws.com"
      ]
    }
  }
}

module "kms" {
  source  = "cloudposse/kms-key/aws"
  version = "0.12.2"

  enabled    = var.slack_notifications_enabled == false ? true : false
  attributes = ["budgets"]

  description             = "Used to encrypt budget notification data"
  deletion_window_in_days = var.kms_key_deletion_window_in_days
  enable_key_rotation     = var.kms_enable_key_rotation

  policy = join("", data.aws_iam_policy_document.kms[*].json)

  context = module.this.context
}

module "sns_topic" {
  source  = "cloudposse/sns-topic/aws"
  version = "0.21.0"

  enabled    = var.slack_notifications_enabled == false ? true : false
  attributes = ["budgets"]

  allowed_aws_services_for_sns_published = ["budgets.amazonaws.com"]

  encryption_enabled = var.encryption_enabled
  kms_master_key_id  = module.kms.key_id

  context = module.this.context
}
