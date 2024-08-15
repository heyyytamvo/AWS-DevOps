# Security Group for EC2 Bastion
resource "aws_security_group" "Bastion_SG" {
  name        = "Bastion_SG"
  description = "Allow HTTP inbound and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress = [
  {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow inbound traffic on port 80"
    ipv6_cidr_blocks = []
    prefix_list_ids   = []
    security_groups   = []
    self             = false
  },

  {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"],
    description      = "Allow inbound ICMP Traffic"
    ipv6_cidr_blocks = []
    prefix_list_ids   = []
    security_groups   = []
    self             = false
  },

  {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow inbound traffic on port 22"
    ipv6_cidr_blocks = []
    prefix_list_ids   = []
    security_groups   = []
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

# Bastion Host
resource "aws_instance" "bastion_host" {

    ami                    = var.ec2_ami
    instance_type          = var.ec2_instance_type
    key_name               = aws_key_pair.EC2key.key_name
    monitoring             = true
    subnet_id              = aws_subnet.public_subnet_2.id
    vpc_security_group_ids = [aws_security_group.Bastion_SG.id]
    associate_public_ip_address = true
    user_data = <<EOF
#!/bin/bash
sudo apt update -y

sudo add-apt-repository ppa:ondrej/php
sudo apt update -y
sudo apt install -y apache2-utils
EOF
    tags = {
        Terraform   = "true"
        Environment = "dev"
        Name        = var.ec2_name
    }
}