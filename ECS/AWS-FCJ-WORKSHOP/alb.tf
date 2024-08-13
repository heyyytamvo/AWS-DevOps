# Security Group for ALB
resource "aws_security_group" "ALB_SG" {
  name        = "ALB SG"
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
]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB SG"
  }
}

resource "aws_alb" "alb_vlsm" {
  name               = "ALB-ECS"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALB_SG.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  enable_deletion_protection = false


  tags = {
    Environment = "production"
  }
}

resource "aws_alb_listener" "alb_listener_http" {
  load_balancer_arn = aws_alb.alb_vlsm.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Access denied"
      status_code  = "403"
    }
  }
}

## Target Group for our service

resource "aws_alb_target_group" "alb_target_group" {
  name                 = "TargetGroupForService"
  port                 = "80"
  protocol             = "HTTP"
  vpc_id               = aws_vpc.main.id
  deregistration_delay = 120

  health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
    interval            = "60"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "30"
  }
}


resource "aws_alb_listener_rule" "alb_listener_http" {
  listener_arn = aws_alb_listener.alb_listener_http.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}