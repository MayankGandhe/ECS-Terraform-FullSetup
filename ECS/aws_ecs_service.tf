 resource "aws_ecs_service" "service" {
  name            = "${var.app_name}-${var.environment}"
  cluster         = var.cluster_id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.task_definition.id
  desired_count   = "${var.taskDesiredCount}"
  deployment_circuit_breaker {
       enable=true
       rollback=true
    }
 

 network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.staging.id]
    subnets          = var.subnets
  }


   dynamic "load_balancer" {
   for_each = var.tgARN
   content{
   target_group_arn =  load_balancer.value
    container_name   = var.container_name
    container_port   = var.containerPort
  }
  
  }
   tags = var.tags

#   placement_constraints {
#     type       = "memberOf"
#     expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
#   }

#   ordered_placement_strategy {
#     type  = "binpack"
#     field = "cpu"
#   }
}
