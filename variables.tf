variable "gcp_spoke_name" {
  type    = string
}

variable "gcp_account_name" {
  description = "The name of the GCP Access Account in Aviatrix Controller"
}

variable "gcp_gw_size" {
  description = "The size of the GCP Aviatrix Spoke Gateway"
  default     = "n1-standard-1"
}

variable "gcp_spoke_region" {
  description = "The GCP region to launch the Spoke subnet"
}

variable "gcp_spoke_sub1_cidr" {
  description = "The CIDR of the Spoke subnet"
}

variable "transit_gateway" {
  description = "The name of the Aviatrix Transit Gateway to attach Spoke Gateway to"
}