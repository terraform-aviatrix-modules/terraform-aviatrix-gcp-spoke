output "gcp_spoke_vpc" {
  description = "The name of the Aviatrix Spoke VPC"
  value       = aviatrix_vpc.gcp_spoke_vpc
}

output "gcp_spoke_gateway" {
  description = "The name of the Aviatrix Spoke Gateway"
  value       = aviatrix_spoke_gateway.gcp_spoke_gw.gw_name
}