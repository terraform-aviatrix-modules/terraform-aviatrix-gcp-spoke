output "vpc" {
  description = "Returns aviatrix_vpc object and all of its attributes"
  value       = var.ha_region ? aviatrix_vpc.ha_region[0] : aviatrix_vpc.single_region[0]
}

output "spoke_gateway" {
  description = "Return Aviatrix Spoke Gateway with all attributes"
  value       = var.ha_gw ? aviatrix_spoke_gateway.ha[0] : aviatrix_spoke_gateway.single[0]
}