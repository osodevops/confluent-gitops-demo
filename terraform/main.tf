terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "0.8.1"
    }
  }
}

provider "confluent" {
  api_key    = var.confluent_cloud_api_key
  api_secret = var.confluent_cloud_api_secret
}

#resource "confluent_environment" "environment" {
#  display_name = var.environment_name
#}
#
### Update the config to use a cloud provider and region of your choice.
### https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_kafka_cluster
#resource "confluent_kafka_cluster" "cluster" {
#  display_name = "demo"
#  availability = "SINGLE_ZONE"
#  cloud        = "AZURE"
#  region       = var.cluster_region
#  standard {}
#  #  basic {}
#  environment {
#    id = confluent_environment.environment.id
#  }
#}
##
#// A service account is required in this configuration to create topics and grant ACLs
#// to 'producer' and 'consumer' service accounts.
#resource "confluent_service_account" "demo-manager" {
#  display_name = "demo-manager"
#  description  = "Service account to manage 'inventory' Kafka cluster"
#}