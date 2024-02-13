output "cog" {
  value       = azurerm_cognitive_account.cognitive_service
  sensitive   = true
  description = "The Cognitive Service Object."
}
output "name" {
  value       = azurerm_cognitive_account.cognitive_service.name
  description = "The name of the Cognitive Service"
}
output "id" {
  value       = azurerm_cognitive_account.cognitive_service.id
  description = "The ID of the Cognitive Service"
}
output "private_endpoint_name" {
  value       = try(azurerm_private_endpoint.private_endpoint[0].name, null)
  description = "Private link endpoint name."
}

output "private_dns_zone_id" {
  value       = try(azurerm_private_endpoint.private_endpoint[0].private_dns_zone_group[0].private_dns_zone_ids[0], null)
  description = "Private DNS Zone id."
}


