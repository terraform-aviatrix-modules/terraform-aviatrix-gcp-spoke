output "gcp_spoke_vpc" {
  value = aviatrix_vpc.gcp_spoke_vpc
}

output "gcp_spoke_gateway" {
  value = aviatrix_spoke_gateway.gcp_spoke_gw.gw_name
}