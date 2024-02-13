<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.69.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cognitive_account.cognitive_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account) | resource |
| [azurerm_monitor_diagnostic_setting.cognitive_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_monitor_diagnostic_categories.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_subdomain_name"></a> [custom\_subdomain\_name](#input\_custom\_subdomain\_name) | Custom name of subdomain of endpoint. | `string` | n/a | yes |
| <a name="input_deployment_environment"></a> [deployment\_environment](#input\_deployment\_environment) | Deployment environment for the host of this cognitive service. | `string` | n/a | yes |
| <a name="input_diagnostics"></a> [diagnostics](#input\_diagnostics) | Diagnostic settings for those resources that support it. | <pre>object({<br>    log_analytics_id = string,<br>    logs             = list(string),<br>    metrics          = list(string)<br>  })</pre> | `null` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Create private endpoint for Cognitive Resource. | `bool` | `false` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | Kind of Azure Cognitive Service to be created. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Cognitive Service should exist. | `string` | `"westeurope"` | no |
| <a name="input_network_acls_subnet_id"></a> [network\_acls\_subnet\_id](#input\_network\_acls\_subnet\_id) | ID of the subnet that the private endpoint should allow access from. | `string` | `null` | no |
| <a name="input_private_dns_zone_resource_group_id"></a> [private\_dns\_zone\_resource\_group\_id](#input\_private\_dns\_zone\_resource\_group\_id) | Resource group of the Private Link DNS zone to be used for the Cognitive Service endpoint. | `string` | `"/subscriptions/02e2f460-09b1-490f-bbbc-1643413ca5b4/resourceGroups/nw-hub-pep-pdns-rg-001"` | no |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint, i.e. a subnet dedicated to the private endpoint. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Allow public access. | `bool` | `false` | no |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | Name of the app or function of the host for which this cognitive service is created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group where the Cognitive Service should exist. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The pricing tier of the search service you want to create (for example, basic or standard). | `string` | `"S0"` | no |
| <a name="input_subscription_alias"></a> [subscription\_alias](#input\_subscription\_alias) | Alias of the subscription in which the host resource for this cognitive service exists. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to the Cognitive Services resource | `map(string)` | `{}` | no |
| <a name="input_unique_identifier"></a> [unique\_identifier](#input\_unique\_identifier) | An optional unique identifier (if needed) for the name of this cognitive service. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cog"></a> [cog](#output\_cog) | The Cognitive Service Object. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Cognitive Service |
| <a name="output_name"></a> [name](#output\_name) | The name of the Cognitive Service |
| <a name="output_private_dns_zone_id"></a> [private\_dns\_zone\_id](#output\_private\_dns\_zone\_id) | Private DNS Zone id. |
| <a name="output_private_endpoint_name"></a> [private\_endpoint\_name](#output\_private\_endpoint\_name) | Private link endpoint name. |
<!-- END_TF_DOCS -->
