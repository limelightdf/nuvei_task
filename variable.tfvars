# Provider variables
aws_access_key = "complete-this"
aws_secret_key = "complete-this"
aws_region     = "eu-west-1"

# network-main variables
# aws availability zone
aws_az = ["eu-west-1b", "eu-west-1c"]

# vpc variables
vpc_cidr = "10.0.0.0/16"

# subnet variables
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
subnet_count        = 2

# network interface variables
private_ips = ["10.0.1.50", "10.0.1.55"]

# instance variables
instance_count = 2
instance_type  = "t2.micro"

# root disk size variable
linux_root_volume_size = 20
linux_root_volume_type = "gp2"

# extra disk size variable
linux_data_volume_size = 10
linux_data_volume_type = "gp2"

# route 53 variables
domain_name = api.www.nuvei.com
record_name = www.nuvei.com
