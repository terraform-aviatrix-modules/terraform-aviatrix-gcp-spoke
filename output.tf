output "vpc" {
  description = "The name of the Aviatrix Spoke VPC"
  value       = aviatrix_vpc.default
}

output "spoke_gateway" {
  description = "The name of the Aviatrix Spoke Gateway"
  value       = aviatrix_spoke_gateway.default.gw_name
}