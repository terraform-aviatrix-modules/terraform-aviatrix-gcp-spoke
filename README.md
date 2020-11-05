# Terraform Aviatrix GCP Spoke

### Description

This module deploys a GCP VPC and an Aviatrix spoke gateway in GCP attaching it to an Aviatrix Transit Gateway. Defining the Aviatrix Terraform provider is assumed upstream and is not part of this module.

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v2.0.0 | 0.12 | >=6.2 | >=0.2.17
v1.1.1 | 0.12 | | 
v1.1.0 | 0.12 | | 
v1.0.2 | 0.12 | | 
v1.0.1 | 0.12 | |
v1.0.0 | 0.12 | |

### Diagram

<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-gcp-spoke/blob/master/img/spoke-vpc-gcp.png?raw=true">

### Usage Example

#### Single
```
# GCP Spoke Module
module "gcp_spoke_1" {
  source             = "terraform-aviatrix-modules/gcp-spoke/aviatrix"
  version            = "2.0.0"
  
  name               = "spoke1"
  account            = "GCP"
  cidr               = "10.10.0.0/16"
  region             = "us-east1"
  transit_gw         = "Name-of-Aviatrix-Transit-Gateway"
  ha_gw              = false
}

```

#### HA
```
# GCP HA Spoke Module
module "gcp_ha_spoke_1" {
  source             = "terraform-aviatrix-modules/gcp-spoke/aviatrix"
  version            = "2.0.0"

  name               = "spoke1"
  account            = "GCP"
  cidr               = "10.10.0.0/16"
  region             = "us-east1"
  transit_gw         = "Name-of-Aviatrix-Transit-Gateway"
}

```

#### Multi-region HA
```
# GCP HA Spoke Module
module "gcp_ha_spoke_1" {
  source             = "terraform-aviatrix-modules/gcp-spoke/aviatrix"
  version            = "2.0.0"

  name               = "spoke1"
  account            = "GCP"
  cidr               = "10.10.0.0/16"
  region             = "us-east1"
  transit_gw         = "Name-of-Aviatrix-Transit-Gateway"

  ha_region          = "us-east4"
  ha_cidr            = "10.20.0.0/16"
}

```

### Variables
The following variables are required:

key | value
--- | ---
name | Provide a name for VPC and Gateway resources. Result will be avx-\<name\>-spoke.
account | The GCP account name on the Aviatrix controller, under which the controller will deploy this VPC
region | GCP region to deploy the spoke VPC, subnet, and gateway in
cidr | The IP CIDR to be used to create the spoke subnet
transit_gw | The transit gateway name to attach the spoke to

The following variables are optional:

key | default | value
--- | --- | ---
ha_gw | true | Boolean to build HA. Cannot be set to false when ha_region is set.
ha_region | ""  | GCP region for multi region HA. HA is multi-az single region by default, but will become multi region when this is set.
ha_cidr | "" | The IP CIDR to be used to create ha_region spoke subnet. Only required when ha_region is set.
instance_size | n1-standard-1 | Size of the transit gateway instances
az1 | b | The zone to deploy the primary gateway in (override if needed)
az2 | c | The zone to deploy the ha gateway in (override if needed)
prefix | true | Boolean to enable prefix name with avx-
suffix | true | Boolean to enable suffix name with -spoke
insane_mode | false | Set to true to enable Aviatrix insane mode high-performance encryption
attached | true | Set to false if you don't want to attach spoke to transit.
security_domain | Provide security domain name to which spoke needs to be deployed. Transit gateway must be attached and have segmentation enabled.
single_az_ha | true | Set to false if Controller managed Gateway HA is desired
single_ip_snat | false | Specify whether to enable Source NAT feature in single_ip mode on the gateway or not. Please disable AWS NAT instance before enabling this feature. Currently only supports AWS(1) and AZURE(8)
customized_spoke_vpc_routes | | A list of comma separated CIDRs to be customized for the spoke VPC routes. When configured, it will replace all learned routes in VPC routing tables, including RFC1918 and non-RFC1918 CIDRs. Example: 10.0.0.0/116,10.2.0.0/16
filtered_spoke_vpc_routes | | A list of comma separated CIDRs to be filtered from the spoke VPC route table. When configured, filtering CIDR(s) or it’s subnet will be deleted from VPC routing tables as well as from spoke gateway’s routing table. Example: 10.2.0.0/116,10.3.0.0/16
included_advertised_spoke_routes | | A list of comma separated CIDRs to be advertised to on-prem as Included CIDR List. When configured, it will replace all advertised routes from this VPC. Example: 10.4.0.0/116,10.5.0.0/16

Outputs
This module will return the following objects:

key | description
--- | ---
vpc | The created vpc as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
spoke_gateway | The created Aviatrix spoke gateway as an object with all of it's attributes.
