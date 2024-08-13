vpc_name = "my-VPC"

vpc_cidr = "10.0.0.0/16"

vpc_azs = ["us-east-1a", "us-east-1b"]

vpc_public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

vpc_private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

# EC2 variables

ec2_name = "Bastion Instance EC2"

ec2_instance_type = "t2.medium"

ec2_key_name = "EC2"

ec2_ami = "ami-0a0e5d9c7acc336f1"  // Ubuntu


ecs_cluster_name = "ECSCluster"

image_name = "heyyytamvo/vlsm:fe"

service_name = "VLSM_FrontEnd_Service"

ecs_task_desired_count = 2