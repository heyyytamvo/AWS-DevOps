vpc_name = "my-VPC"

vpc_cidr = "10.0.0.0/16"

vpc_azs = ["us-east-1a", "us-east-1b"]

vpc_public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

vpc_private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

# EC2 variables

ec2_name = "Bastion Instance EC2"

ec2_instance_type = "t2.medium"

ec2_key_name = "EC2"

# ec2_database_name = "wp_test"

# ec2_database_pass = "a1756660d8893e9b0f953a99ad0fc5373fad38eccbbe0429663a8f4cf0f30562"

ec2_ami = "ami-0a0e5d9c7acc336f1"  // Ubuntu

# rds_db_pass = "passwordispassword"

ecs_cluster_name = "My ECS Cluster"