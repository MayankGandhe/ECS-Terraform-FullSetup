
variable "lBSubnet" {
  description = "subnet for loab balancer"
}

variable "ecsClusterName" {
  description = "cluster name for load balancer target"
}
variable "tags" {
  type = map(string)
  description = "Tags for the ECS and load balancer"
}
variable "port" {
 
  description = "target group port"
}
variable "vpc_id" {
   description = "vpc id"
}
variable "app_name" {
  description = "Name of Application"
}
variable "health_check_enabled" {
  description = "Bool value if healtcheck should be enabled or not "
  default = true
}
variable "environment" {
  
}
variable "isLambda" {
  default = false
}