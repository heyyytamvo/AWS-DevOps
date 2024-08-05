# Security Group for EC2
resource "aws_security_group" "Private_EC2_SG" {
  name        = "Private EC2 Instance"
  description = "Allow all traffic from ALB and SSH From Bastion"
  vpc_id      = aws_vpc.main.id

  ingress = [
  {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = []
    description      = "Allow inbound traffic on port 80 from Bastion Host"
    ipv6_cidr_blocks = []
    prefix_list_ids   = []
    security_groups   = [aws_security_group.Bastion_SG.id]
    self             = false
  },

  {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [],
    description      = "Allow inbound traffic from ALB"
    ipv6_cidr_blocks = []
    prefix_list_ids   = []
    security_groups   = [aws_security_group.ALB_SG.id]
    self             = false
  },
]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private EC2 SG"
  }
}

## Instance
resource "aws_instance" "private_host_test" {
  
    ami                    = var.ec2_ami
    instance_type          = var.ec2_instance_type
    key_name               = aws_key_pair.EC2key.key_name
    monitoring             = true
    subnet_id              = aws_subnet.private_subnet_1.id
    vpc_security_group_ids = [aws_security_group.Private_EC2_SG.id]
    # iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
#     user_data = <<EOF
# #!/bin/bash
# sudo apt update -y
# sudo apt install -y software-properties-common
# sudo add-apt-repository ppa:ondrej/php
# sudo apt update -y
# sudo apt install -y php7.2 php7.2-common php7.2-cli php7.2-fpm
# sudo apt install -y php7.2-{mysql,curl,json,xsl,gd,xml,zip,xsl,soap,bcmath,mbstring,gettext,imagick}
# sudo apt install -y apache2
# EOF
    tags = {
        Terraform   = "true"
        Environment = "dev"
        Name = "EC2 Private Test Instance"
    }
}