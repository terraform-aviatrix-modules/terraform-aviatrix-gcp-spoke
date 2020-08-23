# Aviatrix GCP Spoke VPC
resource "aviatrix_vpc" "default" {
  cloud_type           = 4
  account_name         = var.account
  name                 = "avx-${var.name}-spoke"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnets {
    name   = "${var.name}-subnet"
    cidr   = var.cidr
    region = var.region
  }
}

# Aviatrix GCP Spoke Gateway
resource "aviatrix_spoke_gateway" "default" {
  cloud_type         = 4
  account_name       = var.account
  gw_name            = "avx-${var.name}-spoke"
  vpc_id             = aviatrix_vpc.default.name
  vpc_reg            = "${var.region}-${var.az}"
  gw_size            = var.instance_size
  subnet             = aviatrix_vpc.default.subnets[0].cidr
  enable_active_mesh = true
  transit_gw         = var.transit_gateway
}