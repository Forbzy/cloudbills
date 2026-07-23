variable "github_owner" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "github_username" {
  type = string
}

variable "github_token" {
  type      = string
  sensitive = true
}

variable "compartment_ocid" {
  description = "OCI compartment OCID"
  type        = string
}

variable "cluster_name" {
  default = "cloudbills"
}

variable "kubernetes_version" {
  default = "v1.33.1"
}

variable "node_shape" {
  description = "OCI compute shape for worker nodes"
  type        = string
}

variable "node_count" {
  description = "Number of worker nodes"
  type        = number
}

variable "region" {
  type = string
}