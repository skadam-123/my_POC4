# Create VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.10.0.0/24"
  tags = {
    Name = "my_vpc"
  }
}

# Create Subnet
resource "aws_subnet" "demo-subnet" {
  vpc_id             = aws_vpc.demo-vpc.id
  cidr_block         = "10.10.0.0/24"
  availability_zone  = "ap-south-1a"
  map_public_ip_on_launch  = true
  tags = {
    Name = "vpc-subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "demo-igw"
  }
}

# Create Route Table
resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }

  tags = {
    Name = "demo-rt"
  }
}

# Associate subnet with route table
resource "aws_route_table_association" "demo-rt-association" {
  subnet_id      = aws_subnet.demo-subnet.id
  route_table_id = aws_route_table.demo-rt.id
}

# Create Security group
resource "aws_security_group" "demo-vpc-sg" {
  name        = "demo-vpc-sg"
  description = "Security group for ECS tasks"
  vpc_id      =  aws_vpc.demo-vpc.id

  ingress {
    from_port		= 3000
    to_port    		= 3000
    protocol    	= "tcp"
    cidr_blocks 	= ["0.0.0.0/0"]
  }

  egress  {
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
  }
}
