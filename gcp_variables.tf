variable "gcp_project_id" {
  description = "GCP Project ID."
  type        = string
}

variable "gcp_region" {
  description = "Default to Oregon region."
  default     = "us-west1"
}

variable "gcp_vpc_name" {
  default = "default"
}

variable "gcp_subnet1_cidr" {
  default = "10.240.0.0/24"
}

variable "gcp_pod_cidr" {
  default = "10.204.0.0/14"
}

variable "gcp_services_cidr" {
  default = "10.208.0.0/20"
}


