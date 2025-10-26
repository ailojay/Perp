module "org_budget" {
  source            = "../../modules/global/budgets"
  name              = "org-wide"
  amount            = "10"
  linked_account_id = "" # empty → all accounts
  alert_email       = var.alert_email
}

module "secops_budget" {
  source            = "../../modules/global/budgets"
  name              = "secops"
  amount            = "5"
  linked_account_id = var.secops_account_id
  alert_email       = var.alert_email
}

module "dev_budget" {
  source            = "../../modules/global/budgets"
  name              = "dev"
  amount            = "5"
  linked_account_id = var.dev_account_id
  alert_email       = var.alert_email
}
