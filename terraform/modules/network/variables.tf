#Virtual Private Cloud
variable "vpc_cidr_block" {}
variable "enable_dns_hostnames" {}
variable "vpc_tag" {}

#Subnets
variable "public_subnets_cidrs" {}
variable "private_subnet_cidrs" {}
variable "azs" {}
variable "public_subnets_tag" {}

#Internet Gateway
variable "create_igw" {}
variable "igw_tag" {}

#Route table
variable "route_table_tag" {} 
variable "create_igw_route" {}

