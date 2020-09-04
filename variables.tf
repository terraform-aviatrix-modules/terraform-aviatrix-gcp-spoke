variable "region" {
  description = "Primary GCP region where subnet and Aviatrix Spoke Gateway will be created"
}

variable "ha_region" {
  description = "Secondary GCP region where subnet and HA Aviatrix Spoke Gateway will be created"
  default     = ""
}

variable "account" {
  description = "Name of the GCP Access Account defined in the Aviatrix Controller"
}

variable "instance_size" {
  description = "Size of the compute instance for the Aviatrix Gateways"
  default     = "n1-standard-1"
}

variable "cidr" {
  description = "CIDR of the primary GCP subnet"
}

variable "ha_cidr" {
  description = "CIDR of the HA GCP subnet"
  default     = ""
}

variable "ha_gw" {
  description = "Set to false te deploy a single spoke GW"
  type        = bool
  default     = true
}

variable "az1" {
  description = "The zone to deploy the primary gateway in (override if needed)"
  type        = string
  default     = "b"
}

variable "az2" {
  description = "The zone to deploy the ha gateway in (override if needed)"
  type        = string
  default     = "c"
}

variable "name" {
  description = "Optional to add custom name to created infrastructure"
  type        = string
  default     = ""
}

variable "active_mesh" {
  description = "Boolean to modify Active Mesh if needed"
  type        = bool
  default     = true
}

variable "transit_gateway" {
  description = "Name of the Aviatrix Transit Gateway to attach the GCP spoke to"
  type        = string
  default     = ""
}