variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.150.0.0/16"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "Grippo-vpc"
}

variable "igw_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
  default     = "internet-gateway-grippo"
}

variable "nat_gateway_name" {
  description = "Name tag for the NAT Gateway"
  type        = string
  default     = "nat-gateway-grippo"
}

variable "public_route_table_name" {
  description = "Name tag for the public route table"
  type        = string
  default     = "public-route-grippo"
}

variable "private_route_table_name" {
  description = "Name tag for the private route table"
  type        = string
  default     = "private-route-grippo"
}

# Subnet Variables
variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.150.10.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.150.20.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for private subnet 1"
  type        = string
  default     = "10.150.30.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for private subnet 2"
  type        = string
  default     = "10.150.40.0/24"
}

variable "public_subnet_1_az" {
  description = "Availability zone for public subnet 1"
  type        = string
  default     = "eu-central-1a"
}

variable "public_subnet_2_az" {
  description = "Availability zone for public subnet 2"
  type        = string
  default     = "eu-central-1b"
}

variable "private_subnet_1_az" {
  description = "Availability zone for private subnet 1"
  type        = string
  default     = "eu-central-1a"
}

variable "private_subnet_2_az" {
  description = "Availability zone for private subnet 2"
  type        = string
  default     = "eu-central-1b"
}

# Instance Variables
variable "ami" {
  description = "The AMI ID for the EC2 instances"
  type        = string
  default     = "ami-08ec94f928cf25a9d"
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "web_instance_1_name" {
  description = "Name tag for the first web instance"
  type        = string
  default     = "Srv-105-web"
}

variable "web_instance_2_name" {
  description = "Name tag for the second web instance"
  type        = string
  default     = "Srv-106-web"
}

variable "rds_instance_1_name" {
  description = "Name tag for the first RDS instance"
  type        = string
  default     = "Srv-RDS-405"
}

variable "rds_instance_2_name" {
  description = "Name tag for the second RDS instance"
  type        = string
  default     = "Srv-RDS-406"
}

# Security Group Variables
variable "ssh_port" {
  description = "SSH port for EC2 instances"
  type        = string
  default     = "22"
}

variable "http_port" {
  description = "HTTP port for EC2 instances"
  type        = string
  default     = "80"
}

variable "postgres_port" {
  description = "PostgreSQL port for RDS instances"
  type        = string
  default     = "5432"
}

variable "public_sg_cidr_blocks" {
  description = "CIDR blocks for public security group ingress"
  type        = string
  default     = "0.0.0.0/0"
}

variable "private_sg_cidr_blocks" {
  description = "CIDR blocks for private security group ingress"
  type        = string
  default     = "10.150.0.0/16"
}
