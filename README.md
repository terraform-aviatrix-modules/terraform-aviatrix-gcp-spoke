# Terraform Aviatrix GCP Spoke

This module deploys a GCP VPC and an Aviatrix spoke gateway in GCP attaching it to an Aviatrix Transit Gateway. Defining the Aviatrix Terraform provider is assumed upstream and is not part of this module.

### Diagram

<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-gcp-spoke/blob/master/spoke-vpc-gcp.png?raw=true"  height="250">

### Usage Example

#### Single
```
# GCP Spoke Module
module "gcp_spoke_1" {
  source             = "terraform-aviatrix-modules/gcp-spoke/aviatrix"
  version            = "1.1.0"
  
  account            = "GCP"
  cidr               = "10.10.0.0/16"
  region             = "us-east1"
  transit_gateway    = "Name-of-Aviatrix-Transit-Gateway"
}

```

#### HA
```
# GCP HA Spoke Module
module "gcp_ha_spoke_1" {
  source             = "terraform-aviatrix-modules/gcp-spoke/aviatrix"
  version            = "1.1.0"

  account            = "GCP"
  cidr               = "10.10.0.0/16"
  region             = "us-east1"
  ha_cidr            = "10.20.0.0/16"
  ha_gw              = true
  ha_region          = "us-east4"
  transit_gateway    = "Name-of-Aviatrix-Transit-Gateway"
}

```

The following variables are required:

key | value
--- | ---
account | The GCP account name on the Aviatrix controller, under which the controller will deploy this VPC
region | GCP region to deploy the spoke VPC, subnet, and gateway in
cidr | The IP CIDR to be used to create the spoke subnet
transit_gateway | The transit gateway name to attach the spoke to

The following variables are optional:

key | default | value
--- | --- | ---
name | null | Optional string to add custom name to created infrastructure
ha_gw | false | Boolean to build HA, when set ha_reqion and ha_cidr must be specified
ha_region | null | GCP region to deploy HA spoke VPC, subnet, and gateway in
ha_cidr |null| The IP CIDR to be used to create the spoke subnet
instance_size | n1-standard-1 | Size of the transit gateway instances
az1 | b | The zone to deploy the primary gateway in (override if needed)
az2 | c | The zone to deploy the ha gateway in (override if needed)

Outputs
This module will return the following objects:

key | description
--- | ---
vpc | The created vpc as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
spoke_gateway | The created Aviatrix spoke gateway name