provider "aws" {
  region = var.aws_region
}

# Create the VPC
resource "aws_vpc" "grippo_vpc" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
  }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "grippo_igw" {
  vpc_id = aws_vpc.grippo_vpc.id
  tags = {
    Name = var.igw_name
  }
}

# Create the NAT Gateway (requires an Elastic IP)
resource "aws_eip" "grippo_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "grippo_nat" {
  allocation_id = aws_eip.grippo_eip.id
  subnet_id     = aws_subnet.grippo_public_subnet_1.id
  tags = {
    Name = var.nat_gateway_name
  }
}

# Create the public route table and associate with subnets
resource "aws_route_table" "grippo_public_route" {
  vpc_id = aws_vpc.grippo_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.grippo_igw.id
  }
  tags = {
    Name = var.public_route_table_name
  }
}

# Create the private route table and associate with NAT gateway
resource "aws_route_table" "grippo_private_route" {
  vpc_id = aws_vpc.grippo_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.grippo_nat.id
  }
  tags = {
    Name = var.private_route_table_name
  }
}

# Public Subnet 1
resource "aws_subnet" "grippo_public_subnet_1" {
  vpc_id            = aws_vpc.grippo_vpc.id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = var.public_subnet_1_az
  tags = {
    Name = "public-subnet-1"
  }
}

# Public Subnet 2
resource "aws_subnet" "grippo_public_subnet_2" {
  vpc_id            = aws_vpc.grippo_vpc.id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = var.public_subnet_2_az
  tags = {
    Name = "public-subnet-2"
  }
}

# Private Subnet 1
resource "aws_subnet" "grippo_private_subnet_1" {
  vpc_id            = aws_vpc.grippo_vpc.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.private_subnet_1_az
  tags = {
    Name = "private-subnet-1"
  }
}

# Private Subnet 2
resource "aws_subnet" "grippo_private_subnet_2" {
  vpc_id            = aws_vpc.grippo_vpc.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.private_subnet_2_az
  tags = {
    Name = "private-subnet-2"
  }
}

# Route table associations
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.grippo_public_subnet_1.id
  route_table_id = aws_route_table.grippo_public_route.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.grippo_public_subnet_2.id
  route_table_id = aws_route_table.grippo_public_route.id
}

resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.grippo_private_subnet_1.id
  route_table_id = aws_route_table.grippo_private_route.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.grippo_private_subnet_2.id
  route_table_id = aws_route_table.grippo_private_route.id
}

# EC2 Instances
resource "aws_instance" "web_instance_1" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.grippo_public_subnet_1.id
  associate_public_ip_address = true
  tags = {
    Name = var.web_instance_1_name
  }
}

resource "aws_instance" "web_instance_2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.grippo_public_subnet_2.id
  associate_public_ip_address = true
  tags = {
    Name = var.web_instance_2_name
  }
}

resource "aws_instance" "rds_instance_1" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.grippo_private_subnet_1.id
  tags = {
    Name = var.rds_instance_1_name
  }
}

resource "aws_instance" "rds_instance_2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.grippo_private_subnet_2.id
  tags = {
    Name = var.rds_instance_2_name
  }
}

# Security Groups
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.grippo_vpc.id
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.public_sg_cidr_blocks]
  }
  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.public_sg_cidr_blocks]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Private Security Group for RDS Instances
resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.grippo_vpc.id
  ingress {
    from_port   = var.postgres_port
    to_port     = var.postgres_port
    protocol    = "tcp"
    cidr_blocks = [var.private_sg_cidr_blocks]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
