## Creates an ECS Cluster

resource "aws_ecs_cluster" "main" {
  name  = var.ecs_cluster_name

  tags = {
    Name     = var.ecs_cluster_name
  }
}

## Creates ECS Task Definition

resource "aws_ecs_task_definition" "my_ECS_TD" {
  family             = "ECS_TaskDefinition"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_iam_role.arn

  container_definitions = jsonencode([
    {
      name         = var.service_name
      image        = var.image_name
      cpu          = 500
      memory       = 500
      essential    = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = 0
          protocol      = "tcp"
        }
      ]
    }
  ])
}

## Creates ECS Service

resource "aws_ecs_service" "service" {
  name                               = "ECS_Service"
  iam_role                           = aws_iam_role.ecs_service_role.arn
  cluster                            = aws_ecs_cluster.main.id
  task_definition                     = aws_ecs_task_definition.my_ECS_TD.arn
  desired_count                      = var.ecs_task_desired_count

  load_balancer {
    target_group_arn = aws_alb_target_group.alb_target_group.arn
    container_name   = var.service_name
    container_port   = var.container_port
  }

  ## Spread tasks evenly accross all Availability Zones for High Availability
  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }
  
  ## Make use of all available space on the Container Instances
  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

  # Do not update desired count again to avoid a reset to this number on every deploymengit t
  lifecycle {
    ignore_changes = [desired_count]
  }
}

## Creates Capacity Provider linked with ASG and ECS Cluster

resource "aws_ecs_capacity_provider" "cas" {
  name  = "VLSM_CapacityProvider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_autoscaling_group.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 2
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100   // "Amount of resources of container instances that should be used for task placement in %"
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "cas" {
  cluster_name       = aws_ecs_cluster.main.name
  capacity_providers = [aws_ecs_capacity_provider.cas.name]
}