#vpc
resource "aws_vpc" "kartik_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}



#subnet1
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.kartik_vpc.id
  cidr_block              = var.subnet_cidr[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true
}


#subnet2
resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.kartik_vpc.id
  cidr_block              = var.subnet_cidr[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true
}


# internet gateway
resource "aws_internet_gateway" "kartik_gateway" {
  vpc_id = aws_vpc.kartik_vpc.id
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.kartik_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kartik_gateway.id
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}