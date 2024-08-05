## Creates an ECS Cluster

resource "aws_ecs_cluster" "main" {
  name  = var.ecs_cluster_name

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name     = "ECSCluster"
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
      cpu          = 100
      memory       = 100
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
#   deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
#   deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent

  load_balancer {
    target_group_arn = aws_alb_target_group.service_target_group.arn
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

  ## Do not update desired count again to avoid a reset to this number on every deployment
  lifecycle {
    ignore_changes = [desired_count]
  }
}