# Creating VPC
resource "aws_vpc" "prod-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "production"
   }
 }

# Create a Subnet 

resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.aws_az
  subnet_count      = var.subnet_count

  tags = {
    Name = "public-subnet"
  }
 }

resource "aws_subnet" "subnet-2" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = var.private_subnet_cidr 
  availability_zone = var.aws_az
  subnet_count      = var.subnet_count

  tags = {
    Name = "private-subnet"
  }
 }

# Creating Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod-vpc.id
 }

# Creating Custom Route Table

resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Prod"
  }
 }

# Associate subnet with Public Route Table

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.prod-route-table.id
 }

# Creating Security Group to allow port 80,443
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
 }

# Create a network interface with an ip in the subnet that was created

resource "aws_network_interface" "web-server-nic" {
  subnet_id       = ["aws_subnet.subnet-1.id", "aws_subnet.subnet-2.id"]
  private_ips     = var.private_ips
  security_groups = [aws_security_group.allow_web.id]
}

# Assign an elastic IP to the network interface

resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = var.private_ips
  depends_on                = [aws_internet_gateway.gw]
 }

output "server_public_ip" {
  value = aws_eip.one.public_ip
 }

