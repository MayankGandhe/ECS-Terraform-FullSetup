resource "aws_lb_target_group" "target_group" {
  name        ="${var.app_name}-target-group-${var.environment}"   
  port        =  var.port
  protocol    = "HTTP"
  target_type = var.isLambda ? "lambda" : "ip"
  vpc_id      = var.vpc_id
  health_check {
    enabled = var.health_check_enabled
    unhealthy_threshold = 10
    timeout = 120
    interval = 300
    matcher = "200-499"
    path    ="/health"
  }
}
