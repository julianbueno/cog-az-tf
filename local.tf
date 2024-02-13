locals {
  purpose                = var.purpose != null ? "-${var.purpose}" : ""
  deployment_environment = var.deployment_environment != null ? var.deployment_environment : ""
  custom_subdomain_name  = var.custom_subdomain_name
  unique_identifier      = var.unique_identifier != null ? "-${var.unique_identifier}" : ""
  cognitive_service_name = "${var.subscription_alias}-cog-${lower(var.kind)}${local.purpose}-${local.deployment_environment}${local.unique_identifier}"

  # private endpoint
  private_endpoint_name = "${var.subscription_alias}-pep-${lower(var.kind)}${local.purpose}-${local.deployment_environment}${local.unique_identifier}"
  private_dns_zone_name = var.kind == "OpenAI" ? "privatelink.openai.azure.com" : "privatelink.cognitiveservices.azure.com"
  private_dns_zone_id   = var.enable_private_endpoint == false ? null : "${var.private_dns_zone_resource_group_id}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}"

  # diagnostic settings
  parsed_diag = var.diagnostics != null ? {
    log_analytics_id = var.diagnostics.log_analytics_id
    metric           = var.diagnostics.metrics
    log              = var.diagnostics.logs
    } : {
    log_analytics_id = null
    metric           = []
    log              = []
  }
}

