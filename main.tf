resource "aviatrix_vpc" "single" {
  count                = var.ha_gw ? 0 : 1
  cloud_type           = 4
  account_name         = var.account
  name                 = length(var.name) > 0 ? "avx-${var.name}-spoke" : "avx-${var.region}-spoke"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnets {
    name   = "avx-${var.region}-spoke"
    cidr   = var.cidr
    region = var.region
  }
}

resource "aviatrix_vpc" "ha" {
  count                = var.ha_gw ? 1 : 0
  cloud_type           = 4
  account_name         = var.account
  name                 = length(var.name) > 0 ? "avx-${var.name}-spoke" : "avx-${var.region}-spoke"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnets {
    name   = length(var.name) > 0 ? "avx-${var.name}-spoke-primary" : "avx-${var.region}-spoke"
    cidr   = var.cidr
    region = var.region
  }

  subnets {
    name   = length(var.name) > 0 ? "avx-${var.name}-spoke-ha" : "avx-${var.ha_region}-spoke"
    cidr   = var.ha_cidr
    region = var.ha_region
  }
}

resource "aviatrix_spoke_gateway" "single" {
  count              = var.ha_gw ? 0 : 1
  gw_name            = length(var.name) > 0 ? "avx-${var.name}-spoke" : "avx-${var.region}-spoke"
  vpc_id             = aviatrix_vpc.single[0].name
  cloud_type         = 4
  vpc_reg            = "${var.region}-${var.az1}"
  enable_active_mesh = var.active_mesh
  gw_size            = var.instance_size
  account_name       = var.account
  subnet             = aviatrix_vpc.single[0].subnets[0].cidr
  transit_gw         = var.transit_gateway
}

resource "aviatrix_spoke_gateway" "ha" {
  count              = var.ha_gw ? 1 : 0
  gw_name            = length(var.name) > 0 ? "avx-${var.name}-spoke" : "avx-${var.region}-spoke"
  vpc_id             = aviatrix_vpc.ha[0].name
  cloud_type         = 4
  vpc_reg            = "${var.region}-${var.az1}"
  enable_active_mesh = var.active_mesh
  gw_size            = var.instance_size
  account_name       = var.account
  subnet             = aviatrix_vpc.ha[0].subnets[0].cidr
  ha_subnet          = aviatrix_vpc.ha[0].subnets[1].cidr
  ha_gw_size         = var.instance_size
  ha_zone            = "${var.ha_region}-${var.az2}"
  transit_gw         = var.transit_gateway
}