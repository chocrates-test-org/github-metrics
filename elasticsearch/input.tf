variable "dns_zones" {
  description = "The DNS zones to create the certificate for"
  type        = list(string)
}

variable "email" {
  description = "The email address to use for the certificate"
  type        = string
}

variable "kibana_base_url" {
  description = "The base URL for Kibana"
  type        = string
}

variable "namespace" {
  description = "The namespace to deploy to"
  type        = string
}

variable "cluster_issuer_namespace" {
  description = "The namespace of the cluster issuer"
  type        = string
}

variable "kube_config" {
  description = "The kube config to use"
  type        = string
}

variable "client_id" {
  description = "The client ID for the Azure AD application"
  type        = string
}

variable "client_secret" {
  description = "The client secret for the Azure AD application"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the Azure AD application"
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID for the Azure AD application"
  type        = string
}

variable "route53_access_key_id" {
  description = "The AWS Route53 Access Key ID"
  type        = string
}
