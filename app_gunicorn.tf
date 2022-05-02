module "Load_Balancer_gunicorn" {
  source         = "./Load_Balancer"
  lBSubnet       = module.vpc.public_subnets
  ecsClusterName = var.ecsClusterName
  tags           = var.tags
  port           = var.containerPort
  vpc_id         = module.vpc.vpc_id
  app_name       = "gunicorn"
  environment    = var.environment

}

module "ECS_gunicorn" {
  source           = "./ECS"
  subnets          = module.vpc.private_subnets
  ecsClusterName   = var.ecsClusterName
  name_ecs_service = var.name_ecs_service
  taskDesiredCount = var.taskDesiredCount
  imageURI         = var.imageURI
  cpu              = var.cpu
  tgARN            = { tgARN = module.Load_Balancer_gunicorn.tgARN }
  memory           = var.memory
  container_name   = var.container_name
  containerPort    = var.containerPort
  tags             = var.tags
  vpc_id           = module.vpc.vpc_id
  envVariables     = local.envVariables
  cluster_id       = aws_ecs_cluster.cluster.id
  app_name         = "gunicorn"
  command          = ["sh", "runGunicorn.sh"]
  environment      = var.environment


}

output "alb_url_gunicorn" {
  value = module.Load_Balancer_gunicorn.dns_name
}