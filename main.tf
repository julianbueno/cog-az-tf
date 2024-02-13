resource "azurerm_cognitive_account" "cognitive_service" {
  name                          = local.cognitive_service_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku_name                      = var.sku
  kind                          = var.kind
  custom_subdomain_name         = var.custom_subdomain_name
  public_network_access_enabled = var.public_network_access_enabled
  local_auth_enabled            = var.local_auth_enabled
  customer_managed_key {
    key_vault_key_id   = var.key_vault_key_id
    identity_client_id = data.azurerm_user_assigned_identity.this.client_id

  }
  identity {
    type         = var.identity_ids != null ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = var.identity_ids
  }
  dynamic "network_acls" {
    for_each = var.network_acls_subnet_ids != null ? toset(var.network_acls_subnet_ids) : []
    content {
      default_action = network_acls.value.default_action
      ip_rules       = network_acls.value.ip_rules
      dynamic "virtual_network_rules" {
        for_each = network_acls.value.subnet_id != null ? toset(network_acls.value.subnet_id) : []
        content {
          subnet_id = virtual_network_rules.value
        }
      }
    }
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "private_endpoint" {
  depends_on = [
    azurerm_cognitive_account.cognitive_service
  ]
  tags                = var.tags
  count               = var.enable_private_endpoint ? 1 : 0
  name                = local.private_endpoint_name
  location            = var.location
  resource_group_name = lower(var.resource_group_name)
  subnet_id           = var.private_endpoint_subnet_id

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [local.private_dns_zone_id]
  }
  private_service_connection {
    name                           = "${lower(local.cognitive_service_name)}-service-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_cognitive_account.cognitive_service.id
    subresource_names              = ["account"]
  }
}

resource "azurerm_monitor_diagnostic_setting" "cognitive_service" {
  count                      = var.diagnostics != null ? 1 : 0
  name                       = "${local.cognitive_service_name}-diag"
  target_resource_id         = azurerm_cognitive_account.cognitive_service.id
  log_analytics_workspace_id = local.parsed_diag.log_analytics_id
  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.default.log_category_types
    content {
      category = enabled_log.value
    }
  }
  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.default.metrics
    content {
      category = metric.value
      #enabled  = contains(local.parsed_diag.metric, "all") || contains(local.parsed_diag.metric, metric.value)
    }
  }
  depends_on = [
    azurerm_cognitive_account.cognitive_service
  ]
}

