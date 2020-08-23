# Terraform Aviatrix GCP Spoke

This module deploys a VPC and an Aviatrix spoke gateway attaching it to transit gw. Defining the Aviatrix Terraform provider is assumed upstream and is not part of this module.

<img src="https://avtx-tf-modules-images.s3.amazonaws.com/spoke-vpc-gcp.png"  height="250">

The following variables are required:

key | value
--- | ---
name | avx-\<name\>-spoke | Name for this Spoke VPC, Subnet, and Gateway
account | The GCP account name on the Aviatrix controller, under which the controller will deploy this VPC
region | GCP region to deploy the spoke VPC, subnet, and gateway in
cidr | The IP CIDR to be used to create the spoke subnet
transit_gateway | The transit gateway name to attach the spoke to

The following variables are optional:

key | default | value
--- | --- | ---
instance_size | n1-standard-1 | Size of the transit gateway instances
az | b | The availability zone to deploy the gateway in

Outputs
This module will return the following objects:

key | description
--- | ---
vpc | The created vpc as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
spoke_gateway | The created Aviatrix spoke gateway name