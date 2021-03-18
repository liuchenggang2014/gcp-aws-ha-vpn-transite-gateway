

variable "aws_credentials_file_path" {
  description = "Locate the AWS credentials file."
  type        = string
}

variable "aws_region" {
  description = "Default to Oregon region."
  default     = "us-west-2"
}


variable "aws_vpc_id" {
  description = "existing vpc id of wind"
  default     = "vpc-090cfad2516ef3078"
}

variable "aws_routetable_id" {
  description = "existing vpc route table of wind"
  default     = "rtb-0b9cb2cb82642fe95"
}


