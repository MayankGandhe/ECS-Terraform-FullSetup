variable "ecsClusterName" {
  description = "ECS cluster name"
}

variable "name_ecs_service" {
  description = "ecs service name"
}
variable "taskDesiredCount" {
  description = "No. of tasks"
}
variable "imageURI" {
  description = "image uri to be defined in ecs"
}
variable "cpu" {
  description = "CPU"
}
variable "memory" {
  description = "memory"
}

variable "container_name" {
  description = "container name"
}
variable "containerPort" {
  description = "container port"
}

variable "tags" {
  description = "tag for cluster"
}
variable "envVariables" {
  type        = list(any)
  description = "Environment Vairlabes"
}
variable "envVariablesSecrets" {
  default = [  ]
  type        = list(any)
  description = "Environment Vairlabes"
}
variable "instance_class" {
  description = "instance class type"
}
variable "db-password" {
  description = "database password"
}
variable "environment" {
  description = "Ex dev, staging, prod"
}
