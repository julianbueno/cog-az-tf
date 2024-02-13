variable "subscription_alias" {
  type        = string
  description = "Alias of the subscription in which the host resource for this cognitive service exists."
}
variable "purpose" {
  type        = string
  description = "Name of the app or function of the host for which this cognitive service is created."
}
variable "unique_identifier" {
  type        = string
  description = "An optional unique identifier (if needed) for the name of this cognitive service."
}
variable "deployment_environment" {
  type        = string
  description = "Deployment environment for the host of this cognitive service."
  validation {
    condition     = contains(["dev", "test", "acc", "prod"], var.deployment_environment)
    error_message = "Invalid values for environment. Accepted values are dev, test, acc, and prod."
  }
}
variable "kind" {
  description = "Kind of Azure Cognitive Service to be created."
  type        = string
  validation {
    # there are many more options, for now only relevant ones for AI team are listed.
    # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account#kind
    condition     = contains(["CognitiveServices", "OpenAI", "SpeechServices", "TextAnalytics"], var.kind)
    error_message = "Invalid value for resource kind."
  }
}
variable "resource_group_name" {
  description = "The name of the Resource Group where the Cognitive Service should exist."
  type        = string
}
variable "location" {
  description = "The Azure Region where the Cognitive Service should exist."
  type        = string
  default     = "westeurope"
}
variable "sku" {
  description = "The pricing tier of the search service you want to create (for example, basic or standard)."
  default     = "S0"
  type        = string
  validation {
    condition     = contains(["S", "S0"], var.sku)
    error_message = "Invalid value for pricing tier sku."
  }
}
variable "enable_private_endpoint" {
  type        = bool
  description = "Create private endpoint for Cognitive Resource."
  default     = false
}
variable "private_endpoint_subnet_id" {
  type        = string
  description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint, i.e. a subnet dedicated to the private endpoint."
  default     = null
}
variable "network_acls_subnet_ids" {
  type        = list(object({
    default_action = string 
    ip_rules = optional(list(string), [])
    subnet_id = optional(list(string), [])
  }))
  description = "ID of the subnets that the private endpoint should allow access from and IP rules that allow certain ip adresses to be whitelisted"
  default     = null
}
variable "public_network_access_enabled" {
  type        = bool
  description = "Allow public access."
  default     = false
}
variable "custom_subdomain_name" {
  type        = string
  description = "Custom name of subdomain of endpoint."
  default     = null
}
variable "private_dns_zone_resource_group_id" {
  type        = string
  description = "Resource group of the Private Link DNS zone to be used for the Cognitive Service endpoint."
  default     = "/subscriptions/02e2f460-09b1-490f-bbbc-1643413ca5b4/resourceGroups/nw-hub-pep-pdns-rg-001"
}
variable "tags" {
  description = "A map of tags to add to the Cognitive Services resource"
  type        = map(string)
  default     = {}
}
variable "diagnostics" {
  description = "Diagnostic settings for those resources that support it."
  type = object({
    log_analytics_id = string,
    logs             = list(string),
    metrics          = list(string)
  })
  default = null
}
variable "key_vault_key_id" {
  type        = string
  description = "The ID of the Key Vault Key."
}

variable "identity_ids" {
  description = "Specifies a list of user managed identity ids to be assigned. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`"
  type        = list(string)
  default     = null
}

variable "local_auth_enabled" {
  type = bool
  description = "Enables to locally authenticate with the cognitive service"
  default = false
}