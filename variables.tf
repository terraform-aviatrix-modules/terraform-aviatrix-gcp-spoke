variable "name" {
  description = "The name of the GCP Spoke VPC, Subnet and GW"
  type        = string
}

variable "account" {
  description = "The name of the GCP Access Account in Aviatrix Controller"
  type        = string
}

variable "instance_size" {
  description = "The size of the GCP Aviatrix Spoke Gateway"
  default     = "n1-standard-1"
  type        = string
}

variable "region" {
  description = "The GCP region to launch the Spoke subnet"
  type        = string
}

variable "cidr" {
  description = "The CIDR of the Spoke subnet"
  type        = string
}

variable "transit_gateway" {
  description = "The name of the Aviatrix Transit Gateway to attach Spoke Gateway to"
  type        = string
}

variable "az" {
  description = "The availability zone to deploy the gateway in"
  type        = string
  default     = "b"
}
