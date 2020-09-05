resource "aviatrix_vpc" "single_region" {
  count                = length(var.ha_region) > 0 ? 0 : 1
  cloud_type           = 4
  account_name         = var.account
  name                 = "avx-${var.name}-spoke"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnets {
    name   = "avx-${var.region}-spoke"
    cidr   = var.cidr
    region = var.region
  }
}

resource "aviatrix_vpc" "ha_region" {
  count                = length(var.ha_region) > 0 ? 1 : 0
  cloud_type           = 4
  account_name         = var.account
  name                 = "avx-${var.name}-spoke"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnets {
    name   = "avx-${var.name}-spoke"
    cidr   = var.cidr
    region = var.region
  }

  subnets {
    name   = "avx-${var.name}-spoke-ha"
    cidr   = var.ha_cidr
    region = var.ha_region
  }
}

resource "aviatrix_spoke_gateway" "single" {
  count              = var.ha_gw ? 0 : 1
  gw_name            = "avx-${var.name}-spoke"
  vpc_id             = aviatrix_vpc.single_region[0].name
  cloud_type         = 4
  vpc_reg            = "${var.region}-${var.az1}"
  enable_active_mesh = var.active_mesh
  gw_size            = var.instance_size
  account_name       = var.account
  subnet             = aviatrix_vpc.single_region[0].subnets[0].cidr
  transit_gw         = var.transit_gw
}

resource "aviatrix_spoke_gateway" "ha" {
  count              = var.ha_gw ? 1 : 0
  gw_name            = "avx-${var.name}-spoke"
  vpc_id             = length(var.ha_region) > 0 ? aviatrix_vpc.ha_region[0].name : aviatrix_vpc.single_region[0].name
  cloud_type         = 4
  vpc_reg            = "${var.region}-${var.az1}"
  enable_active_mesh = var.active_mesh
  gw_size            = var.instance_size
  account_name       = var.account
  subnet             = length(var.ha_region) > 0 ? aviatrix_vpc.ha_region[0].subnets[0].cidr : aviatrix_vpc.single_region[0].subnets[0].cidr
  ha_subnet          = length(var.ha_region) > 0 ? aviatrix_vpc.ha_region[0].subnets[1].cidr : aviatrix_vpc.single_region[0].subnets[0].cidr
  ha_gw_size         = var.instance_size
  ha_zone            = length(var.ha_region) > 0 ? "${var.ha_region}-${var.az2}" : "${var.region}-${var.az2}"
  transit_gw         = var.transit_gw
}