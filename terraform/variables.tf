variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key (also referred as Cloud API ID)"
  type        = string
  sensitive   = true
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret"
  type        = string
  sensitive   = true
}

variable "environment_name" {
  description = "The environment namespace"
  type        = string
}

variable "cluster_region" {
  description = "The region to deploy Confluent Cloud into"
  type        = string
  default     = "uksouth"
}