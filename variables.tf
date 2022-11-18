# variables for provider

variable "aws_access_key" {
  type = string
  description = "AWS access key"
}
variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}
variable "aws_region" {
  type = string
  description = "AWS region"
}

#variable for Availability Zone
variable "aws_az" {
  type        = string
  description = "AWS AZ"
}

# VPC Variables
variable "vpc_cidr" {
  type        = string
  description = "CIDR for the VPC"
}

# Subnet Variables
variable "public_subnet_cidr" {
  type        = string
  description = "CIDR for the public subnet"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR for the private subnet"
}

variable "subnet_count" {
  type        = number
  description = "number of subnet"
}

# network interface variables
variable "private_ips" {
  type        = string
  description = "private ip for network interface"
}

# instance type variables
variable "instance_type" {
  type        = string
  description = "type of instance to be created"
}

# instance count variables
variable "instance_count" {
  type        = number
  description = "number of instance to be created"
}

# root disk size variable
variable "linux_root_volume_size" {
  type        = number
  description = "the volume size of the instance when created"
} 

variable "linux_root_volume_type" {
  type        = string
  description = "the volume type of the instance when created"
} 

# extra disk size variable
variable "linux_data_volume_size" {
  type        = number
  description = "the volume size of the elastic block storage"
} 

variable "linux_data_volume_type" {
  type        = string
  description = "the volume type of the elastic block storage"
} 

# route 53 variables
variable "domain_name" {
  type        = string
  description = "domain name"
}

variable "record_name" {
  type        = string
  description = "sub domain name"
}