resource "aviatrix_vpc" "default" {
  cloud_type           = 4
  account_name         = var.account
  name                 = local.name
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnets {
    name   = local.name
    cidr   = var.cidr
    region = var.region
  }

  dynamic subnets {
    for_each = length(var.ha_region) > 0 ? ["dummy"] : []
    content {
      name   = "${local.name}-ha"
      cidr   = var.ha_cidr
      region = var.ha_region
    }
  }
}

resource "aviatrix_spoke_gateway" "default" {
  gw_name            = local.name
  vpc_id             = aviatrix_vpc.default.name
  cloud_type         = 4
  vpc_reg            = local.region1
  enable_active_mesh = var.active_mesh
  gw_size            = var.instance_size
  account_name       = var.account
  subnet             = local.subnet
  insane_mode        = var.insane_mode
  ha_subnet          = var.ha_gw ? local.ha_subnet : null
  ha_gw_size         = var.ha_gw ? var.instance_size : null
  ha_zone            = var.ha_gw ? local.region2 : null
  transit_gw         = var.transit_gw
}