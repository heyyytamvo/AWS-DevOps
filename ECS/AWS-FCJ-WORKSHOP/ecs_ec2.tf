resource "aws_security_group" "ECS_EC2_SG"{
  name        = "ECS_EC2_SG"
  description = "Allow traffic from ALB_SG and 22 from Bastion"
  vpc_id      = aws_vpc.main.id

  ingress = [
  {
    from_port        = 1024
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = []
    description      = "Allow all traffic from ALB"
    ipv6_cidr_blocks = []
    prefix_list_ids   = []
    security_groups   = [aws_security_group.ALB_SG.id]
    self             = false
  },

  {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = []
    description      = "Allow SSH traffic from Bastion host"
    ipv6_cidr_blocks = []
    prefix_list_ids   = []
    security_groups  = [aws_security_group.Bastion_SG.id]
    self             = false
  }
]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Bastion SG"
  }
}

data "aws_ami" "amazon_linux_2" {
    most_recent = true

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name   = "owner-alias"
        values = ["amazon"]
    }

    filter {
        name   = "name"
        values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
    }

    owners = ["amazon"]
}

## Launch template for all EC2 instances that are part of the ECS cluster
resource "aws_launch_template" "ecs_launch_template" {
    name                   = "ECS_EC2_LaunchTemplate"
    image_id               = data.aws_ami.amazon_linux_2.id
    instance_type          = var.ec2_instance_type
    key_name               = aws_key_pair.EC2key.key_name
    user_data              = base64encode(templatefile("${path.module}/user_data.sh", {ecs_cluster_name = aws_ecs_cluster.main.name})
)
    vpc_security_group_ids = [aws_security_group.ECS_EC2_SG.id]

    iam_instance_profile {
        arn = aws_iam_instance_profile.ec2_instance_role_profile.arn
    }

    monitoring {
        enabled = true
    }
}
