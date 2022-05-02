region           = "us-east-1"
ecsClusterName   = "livefurnish-cluster"
tags             = { "Purpose" : "staging", "Owner" : "mayank", "Project" : "livefurnish", "ManagedBy" : "Terraform" }
name_ecs_service = "livefurnish-service"
taskDesiredCount = 1
cpu              = 4096
memory           = 8192
container_name   = "nginx-container"
containerPort    = 80
imageURI         = "489910784666.dkr.ecr.us-east-1.amazonaws.com/live:latest"
instance_class   = "db.r5.large"
envVariables = [
  { name = "REDIS_HOST", value = "live.ojeafq.ng.0001.use1.cache.amazonaws.com" },
  { name = "DOMAIN", value = "dev-app-v1.livefurnish.com" },
  { name = "MEDIA_URL", value = "/media/" },
  { name = "HOST_MEDIA_ROOT", value = "/media/" },
  { name = "STATIC_URL", value = "/static/" },
  { name = "SERVER_EMAIL", value = "test@livefurnace.com" },
  { name = "EMAIL_HOST", value = "imap.gmail.com" },
  { name = "EMAIL_PORT", value = "549" },
  { name = "DEFAULT_FROM_EMAIL", value = "value" },
  { name = "EMAIL_HOST_USER", value = "value" },
  { name = "DATABASE_URL", value = "postgres://postgres:8SGVz9WqzB@test-public.c6p2cj0okgnn.us-east-1.rds.amazonaws.com:5432/LF-V3-DB-DEV" },
  { name = "STRIPE_PUBLISHABLE_KEY", value = "value" },
  

]
environment = "dev"








