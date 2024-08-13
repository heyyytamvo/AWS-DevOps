## Creates an ASG linked with our main VPC

resource "aws_autoscaling_group" "ecs_autoscaling_group" {
  name                  = "ECS_ASG"
  max_size              = 4
  min_size              = 2
  vpc_zone_identifier   = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  health_check_type     = "EC2"
  protect_from_scale_in = true

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]

  launch_template {
    id      = aws_launch_template.ecs_launch_template.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
  }

  tag {
    key                 = "Name"
    value               = "ASG For ECS"
    propagate_at_launch = true
  }
}