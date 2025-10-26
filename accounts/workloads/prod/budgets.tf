module "prod_budget" {
  source            = "../../modules/shared/budgets"
  name              = "prod"
  amount            = "5"
  linked_account_id = var.prod_account_id
  alert_email       = var.alert_email
}