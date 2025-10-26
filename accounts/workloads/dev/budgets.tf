module "dev_budget" {
  source            = "../../modules/shared/budgets"
  name              = "dev"
  amount            = "5"
  linked_account_id = var.dev_account_id
  alert_email       = var.alert_email
}