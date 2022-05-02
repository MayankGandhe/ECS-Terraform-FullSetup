# module "Load_Balancer_livefurnish" {
#   source           = "./Load_Balancer"
# #   lBSubnet         = module.vpc.public_subnets
#   ecsClusterName   = var.ecsClusterName
#   tags             = var.tags
#   port             = var.containerPort
#   app_name         = "livefurnish"

#   vpc_id = module.vpc.vpc_id


# }
# module "ECS_livefurnish" {
#   source           = "./ECS"
#   app_name         = "livefurnish"
#   subnets          = module.vpc.private_subnets
#   ecsClusterName   = var.ecsClusterName
#   name_ecs_service = var.name_ecs_service
#   taskDesiredCount = var.taskDesiredCount
#   imageURI         = var.imageURI
#   cpu              = var.cpu
#   tgARN            = {tgARN = module.Load_Balancer_livefurnish.tgARN}
#   memory           = var.memory
#   container_name   = var.container_name
#   containerPort    = var.containerPort
#   tags             = var.tags
#   vpc_id           = module.vpc.vpc_id
#   envVariables     = var.envVariables
#   cluster_id       = aws_ecs_cluster.cluster.id
#   command =  ["sh", "runDaphne.sh"]


# }


# output "alb_url_livefurnish" {
#   value = module.Load_Balancer_livefurnish.dns_name
# }
