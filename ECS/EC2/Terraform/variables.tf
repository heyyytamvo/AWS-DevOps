# VPC variables
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "MyVPC"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# EC2 variables
variable "ec2_name" {
  description = "Name of the EC2 instance"
  type        = string
  default = "test EC2"
}

variable "ec2_instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ec2_key_name" {
  description = "Name of the key pair to use for the EC2 instance"
  type        = string
  default = "EC2"
}

# variable "ec2_database_name" {
#   description = "Name DB in EC2 instance"
#   type        = string
#   default = "wp_test"
# }

# variable "ec2_database_pass" {
#   description = "Password DB in EC2 instance"
#   type        = string
#   default = "a1756660d8893e9b0f953a99ad0fc5373fad38eccbbe0429663a8f4cf0f30562"
# }

variable "ec2_ami" {
  description = "AMI ID for EC2"
  type        = string
  default = "ami-0195204d5dce06d99" // AMZ Linux 2 by default
}

# variable "rds_db_pass" {
#   description = "password for rds"
#   type        = string
#   default = "password" 
# }

variable "ecs_cluster_name" {
  description = "Name for ECS Cluster"
  type        = string
  default = "My ECS Cluster" 
}

variable "image_name" {
  description = "Name for docker image"
  type        = string
  default = "" // None by default
}

variable "service_name" {
  description = "Name for Service"
  type        = string
  default = "Default_Service_Name" // None by default
}

variable "container_port" {
  description = "Exposed port on container"
  type        = number
  default = 3000// 3000 by default
}

variable "ecs_task_desired_count" {
  description = "Desired Task Count"
  type        = number
  default = 2 // 2 by default
}