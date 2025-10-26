resource "aws_budgets_budget" "this" {
  name         = "${var.name}-budget"
  budget_type  = "COST"
  limit_amount = var.amount
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  dynamic "cost_filter" {
    for_each = var.linked_account_id != "" ? [var.linked_account_id] : []
    content {
      name   = "LinkedAccount"
      values = [cost_filter.value]
    }
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [var.alert_email]
  }
}
