# Aviatrix GCP Spoke VPC
resource "aviatrix_vpc" "gcp_spoke_vpc" {
  cloud_type           = 4
  account_name         = var.gcp_account_name
  name                 = "${var.gcp_spoke_name}-vpc"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnets {
    name   = "${var.gcp_spoke_name}-subnet"
    cidr   = var.gcp_spoke_sub1_cidr
    region = var.gcp_spoke_region
  }
}

# Aviatrix GCP Spoke Gateway
resource "aviatrix_spoke_gateway" "gcp_spoke_gw" {
  cloud_type         = 4
  account_name       = var.gcp_account_name
  gw_name            = "${var.gcp_spoke_name}-gw"
  vpc_id             = aviatrix_vpc.gcp_spoke_vpc.name
  vpc_reg            = "${var.gcp_spoke_region}-b"
  gw_size            = var.gcp_gw_size
  subnet             = aviatrix_vpc.gcp_spoke_vpc.subnets[0].cidr
  enable_active_mesh = true
  transit_gw         = var.transit_gateway
}
