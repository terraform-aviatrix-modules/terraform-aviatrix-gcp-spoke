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
  gw_name                           = local.name
  vpc_id                            = aviatrix_vpc.default.name
  cloud_type                        = 4
  vpc_reg                           = local.region1
  enable_active_mesh                = var.active_mesh
  gw_size                           = var.instance_size
  account_name                      = var.account
  subnet                            = local.subnet
  insane_mode                       = var.insane_mode
  ha_subnet                         = var.ha_gw ? local.ha_subnet : null
  ha_gw_size                        = var.ha_gw ? var.instance_size : null
  ha_zone                           = var.ha_gw ? local.region2 : null
  manage_transit_gateway_attachment = false
  single_az_ha                      = var.single_az_ha
  single_ip_snat                    = var.single_ip_snat
  customized_spoke_vpc_routes       = var.customized_spoke_vpc_routes
  filtered_spoke_vpc_routes         = var.filtered_spoke_vpc_routes
  included_advertised_spoke_routes  = var.included_advertised_spoke_routes
}

resource "aviatrix_spoke_transit_attachment" "default" {
  count           = var.attached ? 1 : 0
  spoke_gw_name   = aviatrix_spoke_gateway.default.gw_name
  transit_gw_name = var.transit_gw
}

resource "aviatrix_segmentation_security_domain_association" "default" {
  count                = var.attached ? (length(var.security_domain) > 0 ? 1 : 0) : 0 #Only create resource when attached and security_domain is set.
  transit_gateway_name = var.transit_gw
  security_domain_name = var.security_domain
  attachment_name      = aviatrix_spoke_gateway.default.gw_name
  depends_on           = [aviatrix_spoke_transit_attachment.default] #Let's make sure this cannot create a race condition
}
