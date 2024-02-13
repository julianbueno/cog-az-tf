data "azurerm_monitor_diagnostic_categories" "default" {
  resource_id = azurerm_cognitive_account.cognitive_service.id
}

data "azurerm_user_assigned_identity" "this" {
  name                = split("/", var.identity_ids[0])[8]
  resource_group_name = split("/", var.identity_ids[0])[4]
  }
