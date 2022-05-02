region           = "us-east-1"
ecsClusterName   = "test-cluster"
tags             = { "Purpose" : "staging", "Owner" : "mayank", "Project" : "testing", "ManagedBy" : "Terraform" }
name_ecs_service = "livefurnish-service"
taskDesiredCount = 1
cpu              = 1024
memory           = 2048
container_name   = "nginx-container"
containerPort    = 80
imageURI         = "nginx:latest"
instance_class   = "db.r5.large"
envVariables = [
  { name = "ENV_ONE", value = "thisIsForTesting" },

  

]
environment = "dev"








