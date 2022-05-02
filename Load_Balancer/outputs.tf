output "tgARN" {
   value = aws_lb_target_group.target_group.arn
 }

 output "dns_name"{
   value = aws_lb.load_balancer.dns_name
 }