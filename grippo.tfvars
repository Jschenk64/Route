aws_region                 = "eu-central-1"
vpc_cidr                   = "10.150.0.0/16"
vpc_name                   = "Grippo-vpc"
igw_name                   = "internet-gateway-grippo"
nat_gateway_name           = "nat-gateway-grippo"
public_route_table_name    = "public-route-grippo"
private_route_table_name   = "private-route-grippo"

# Subnet Variables
public_subnet_1_cidr       = "10.150.10.0/24"
public_subnet_2_cidr       = "10.150.20.0/24"
private_subnet_1_cidr      = "10.150.30.0/24"
private_subnet_2_cidr      = "10.150.40.0/24"
public_subnet_1_az         = "eu-central-1a"
public_subnet_2_az         = "eu-central-1b"
private_subnet_1_az        = "eu-central-1a"
private_subnet_2_az        = "eu-central-1b"

# Instance Variables
ami                        = "ami-08ec94f928cf25a9d"
instance_type              = "t2.micro"
web_instance_1_name        = "Srv-105-web"
web_instance_2_name        = "Srv-106-web"
rds_instance_1_name        = "Srv-RDS-405"
rds_instance_2_name        = "Srv-RDS-406"

# Security Group Variables
ssh_port                   = "22"
http_port                  = "80"
postgres_port              = "5432"
public_sg_cidr_blocks      = "0.0.0.0/0"
private_sg_cidr_blocks     = "10.150.0.0/16"
