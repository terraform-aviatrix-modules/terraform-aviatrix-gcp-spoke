output "vpc" {
  description = "Returns aviatrix_vpc object and all of its attributes"
  value       = aviatrix_vpc.default
}

output "spoke_gateway" {
  description = "Return Aviatrix Spoke Gateway with all attributes"
  value       = aviatrix_spoke_gateway.default
}