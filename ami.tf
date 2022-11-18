# Getting Ubuntu version 22.04 AMI
data "aws_ami" "ubuntu-linux-2204" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20220912"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}