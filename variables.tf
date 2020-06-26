variable "username" {
  type    = string
  default = ""
}

variable "password" {
  type    = string
  default = ""
}

variable "controller_ip" {
  type    = string
  default = ""
}

variable "gcp_primary_region" {
  default = ""
}

variable "gcp_ha_region" {
  default = ""
}

variable "gcp_account_name" {
  default = ""
}

variable "gcp_gw_size" {
  default = "n1-standard-1"
}

variable "gcp_sub1_cidr" {
  default = ""
}

variable "gcp_sub2_cidr" {
  default = ""
}

variable "gcp_spoke_region" {
  default = "us-central1"
}

variable "gcp_spoke_sub1_cidr" {
  default = ""
}

variable "gcp_transit_gw" {
  default = ""
}