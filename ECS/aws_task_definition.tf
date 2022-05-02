
resource "aws_ecs_task_definition" "task_definition" {
  family ="${var.app_name}-Task-${var.environment}"               
  network_mode="awsvpc"
  execution_role_arn= aws_iam_role.ecs_tasks_execution_role.arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.cpu}"
  memory                   = "${var.memory}"
  container_definitions = jsonencode([
    {
      name      = "${var.container_name}"
      image     = "${var.imageURI}"
      cpu       = "${var.cpu}"
      environment = var.envVariables
      memory    = "${var.memory}"
      command   = var.command
      essential = true
      logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/live-furnish-ecs"
        awslogs-stream-prefix = "ecs"
        awslogs-create-group = "true"
        awslogs-region        = "us-east-1"
      }
    }
      portMappings = [
        {
          containerPort = "${var.containerPort}"
          protocol      = "tcp"
        }
      ]
    }
  ])
   
}

#   volume {
#     name      = "service-storage"
#     host_path = "/ecs/service-storage"
#   }

#   placement_constraints {
#     type       = "memberOf"
#     expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
#   }

