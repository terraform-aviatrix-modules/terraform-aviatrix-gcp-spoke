variable "region" {
  description = "Primary GCP region where subnet and Aviatrix Spoke Gateway will be created"
  type        = string
}

variable "ha_region" {
  description = "Secondary GCP region where subnet and HA Aviatrix Spoke Gateway will be created"
  type        = string
  default     = ""
}

variable "account" {
  description = "Name of the GCP Access Account defined in the Aviatrix Controller"
  type        = string
}

variable "instance_size" {
  description = "Size of the compute instance for the Aviatrix Gateways"
  type        = string
  default     = "n1-standard-1"
}

variable "cidr" {
  description = "CIDR of the primary GCP subnet"
  type        = string
}

variable "ha_cidr" {
  description = "CIDR of the HA GCP subnet"
  type        = string
  default     = ""
}

variable "ha_gw" {
  description = "Set to false te deploy a single spoke GW"
  type        = bool
  default     = true
}

variable "az1" {
  description = "Concatenates with region to form az names. e.g. us-east1b."
  type        = string
  default     = "b"
}

variable "az2" {
  description = "Concatenates with region or ha_region (depending whether ha_region is set) to form az names. e.g. us-east1c."
  type        = string
  default     = "c"
}

variable "name" {
  description = "Name for this spoke VPC and it's gateways"
  type        = string
}

variable "active_mesh" {
  description = "Boolean to modify Active Mesh if needed"
  type        = bool
  default     = true
}

variable "transit_gw" {
  description = "Name of the Aviatrix Transit Gateway to attach the GCP spoke to"
  type        = string
}