# Terraform Aviatrix GCP Spoke

This module deploys a GCP VPC and an Aviatrix spoke gateway in GCP attaching it to an Aviatrix Transit Gateway. Defining the Aviatrix Terraform provider is assumed upstream and is not part of this module.

### Diagram

<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-gcp-spoke/blob/master/img/spoke-vpc-gcp.png?raw=true">

### Usage Example

#### Single
```
# GCP Spoke Module
module "gcp_spoke_1" {
  source             = "terraform-aviatrix-modules/gcp-spoke/aviatrix"
  version            = "1.1.0"
  
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
  version            = "1.1.0"

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
  version            = "1.1.0"

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

Outputs
This module will return the following objects:

key | description
--- | ---
vpc | The created vpc as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
spoke_gateway | The created Aviatrix spoke gateway as an object with all of it's attributes.