vpc_name = "VPC for Kubernetes"

vpc_cidr = "10.0.0.0/16"

vpc_azs = ["us-east-1a", "us-east-1b"]

vpc_public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

vpc_private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

# EC2 variables

ec2_name = "Instance EC2"

ec2_instance_type = "t2.medium"

ec2_key_name = "EC2"

ec2_ami = "ami-0e86e20dae9224db8" // Ubuntu 20.04