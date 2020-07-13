variable "gcp_account_name" {
  description = "The name of the GCP Access Account in Aviatrix Controller"
  default     = ""
}

variable "gcp_gw_size" {
  description = "The size of the GCP Aviatrix Spoke Gateway"
  default     = "n1-standard-1"
}

variable "gcp_spoke_region" {
  description = "The GCP region to launch the Spoke subnet"
  default     = "us-central1"
}

variable "gcp_spoke_sub1_cidr" {
  description = "The CIDR of the Spoke subnet"
  default     = ""
}

variable "avx_transit_gw" {
  description = "The name of the Aviatrix Transit Gateway to attach Spoke Gateway to"
  default     = ""
}