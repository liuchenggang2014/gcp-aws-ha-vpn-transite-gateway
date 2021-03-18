# https://registry.terraform.io/modules/terraform-aws-modules/transit-gateway/aws/latest
# https://registry.terraform.io/modules/spotify/aws-hybrid-cloud-vpn/google/latest
# Routes in the AWS Transit Gateway route table will not be propagated to the Amazon VPC’s route table.
# Amazon VPC owner need to create static route to send Traffic to the AWS Transit Gateway.


provider "google" {
  project = var.gcp_project_id

  region = var.gcp_region
}

provider "google-beta" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

provider "aws" {
  shared_credentials_file = pathexpand(var.aws_credentials_file_path)
  region                  = var.aws_region
}

data "aws_vpc" "right" {
  id = var.aws_vpc_id
}

data "aws_subnet_ids" "right" {
  vpc_id = data.aws_vpc.right.id
}


module "tgw-eu-west-1" {
  source          = "terraform-aws-modules/transit-gateway/aws"
  name            = "tgw-example-eu-west-1"
  description     = "TGW example vpn to gcp"
  amazon_side_asn = "64512"

  enable_auto_accept_shared_attachments = true
  ram_allow_external_principals         = true

  tags = {
    Purpose = "tgw example"
  }

  vpc_attachments = {
    vpc1 = {
      vpc_id     = data.aws_vpc.right.id        # module.vpc1.vpc_id
      subnet_ids = data.aws_subnet_ids.right.ids # module.vpc1.private_subnets
    }
  }
}


module "cb-us-east-1" {
  source             = "github.com/spotify/terraform-google-aws-hybrid-cloud-vpn"
  transit_gateway_id = module.tgw-eu-west-1.this_ec2_transit_gateway_id
  google_network     = var.gcp_vpc_name
  amazon_side_asn    = 64512
  google_side_asn    = 65534
}


resource "aws_route" "r" {
  route_table_id            = var.aws_routetable_id
  destination_cidr_block    = var.gcp_subnet1_cidr
  transit_gateway_id = module.tgw-eu-west-1.this_ec2_transit_gateway_id
}

