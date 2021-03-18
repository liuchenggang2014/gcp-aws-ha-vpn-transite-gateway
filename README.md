# override the variable in terraform.tfvars

- aws_credentials_file_path:     credential file path

- aws_region: aws vpc region

- aws_vpc_id: aws vpc id

- aws_routetable_id = aws vpc route table id: associate it with the subnet where your workload lives in

- gcp_project_id: gcp projectid

- gcp_region: gcp region to hold the cloud router

- gcp_vpc_name: gcp vpc name

- gcp_subnet1_cidr: gcp subnet cidr, this is manually into vpc route table because the vpc can not get the bgp from transite gateway

# terraform steps
```
terraform init
terraform apply
terraform destroy
```