
variable "region" {
  description = "The AWS region where resources will be created"
  type        = string
}

#vpc:

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_instance_tenancy" {
  description = "Instance tenancy for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}


#pub_subnets:


variable "availability_zone_1" {
  description = "Availability Zone for Subnet 01"
  type        = string
}

variable "pub_subnet1_cidr" {
  description = "cidr block for Subnet 01"
  type        = string
}

variable "pub_subnet1_name" {
  description = "Name tag for the Subnet 01"
  type        = string
}


variable "availability_zone_2" {
  description = "Availability Zone for Subnet 02"
  type        = string
}

variable "pub_subnet2_cidr" {
  description = "cidr block for Subnet 02"
  type        = string
}

variable "pub_subnet2_name" {
  description = "Name tag for the Subnet 02"
  type        = string
}


#priv_subnets:

variable "availability_zone_3" {
  description = "Availability Zone for Subnet 03"
  type        = string
}

variable "priv_subnet1_cidr" {
  description = "cidr block for Subnet 03"
  type        = string
}

variable "priv_subnet1_name" {
  description = "Name tag for the Subnet 03"
  type        = string
}



variable "availability_zone_4" {
  description = "Availability Zone for Subnet 04"
  type        = string
}

variable "priv_subnet2_cidr" {
  description = "cidr block for Subnet 04"
  type        = string
}

variable "priv_subnet2_name" {
  description = "Name tag for the Subnet 04"
  type        = string
}


# pub_route_table:

variable "pub_route_table_name" {
  description = "Name tag for the public route table"
  type        = string
}


# priv_route_table:

variable "priv_route_table_name" {
  description = "Name tag for the private route table"
  type        = string
}


# public instance:

#variable "pub_instance_ami" {
#  description = "AMI ID for the public EC2 instance"
#}

#variable "pub_instance_type" {
#  description = "Instance type for the public EC2 instance"
#}

#variable "pub_instance_key_name" {
#  description = "Key pair name for the public EC2 instance"
#}

#variable "pub_instance_name" {
#  description = "Name for the public EC2 instance"
#}


# private instance:

# variable "priv_instance_ami" {
#  description = "AMI ID for the private EC2 instance"
#}

#variable "priv_instance_type" {
#  description = "Instance type for the private EC2 instance"
#}

#variable "priv_instance_key_name" {
#  description = "Key pair name for the private EC2 instance"
#}

#variable "priv_instance_name" {
#  description = "Name for the private EC2 instance"
#}


#ECS Cluster
variable "ecs_cluster_name" {
  description = "This variable represents the name of the ECS (Elastic Container Service) cluster you want to create."
  type        = string
}

variable "instance_type" {
  description = "This variable represents the EC2 (Elastic Compute Cloud) instance type you want to use for your ECS cluster. It defines the compute and memory capacity of the instances."
  type        = string
}

variable "desired_capacity" {
  description = "This variable determines the desired number of EC2 instances to run in an Auto Scaling group. It is typically used in combination with min_size and max_size to configure Auto Scaling."
  type        = number
}

variable "max_size" {
  description = "This variable represents the maximum number of EC2 instances that can be created in an Auto Scaling group. It helps define the upper limit for scaling."
  type        = number
}

variable "min_size" {
  description = "This variable represents the minimum number of EC2 instances that should be running in an Auto Scaling group, ensuring that the group always has at least this number of instances."
  type        = number
}

variable "key_name" {
  description = "This variable is used to specify the name of the SSH key pair that should be associated with the EC2 instances. It allows you to SSH into the instances securely."
  type        = string
}

variable "subnet_ids" {
  description = "This variable represents the list of subnet IDs where the ECS instances will be launched."
  type        = list(string)
}

variable "vpc_id" {
  description = "This variable represents the ID of the VPC where the ECS cluster will be created."
  type        = string
}

#Ecs Task Defination
#resource "aws_ecs_task_definition" "ecs_task_definition" {


#}
