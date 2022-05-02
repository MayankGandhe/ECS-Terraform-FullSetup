module "ECS_celery_beat" {
  source           = "./ECS"
  subnets          = module.vpc.private_subnets
  ecsClusterName   = var.ecsClusterName
  name_ecs_service = var.name_ecs_service
  taskDesiredCount = var.taskDesiredCount
  imageURI         = var.imageURI
  cpu              = 256
  tgARN            = {}
  memory           = 1024
  container_name   = var.container_name
  containerPort    = var.containerPort
  tags             = var.tags
  vpc_id           = module.vpc.vpc_id
  envVariables     = var.envVariables
  cluster_id       = aws_ecs_cluster.cluster.id
  app_name         = "celery_beat"
  command          = ["sh", "runCeleryBeat.sh"]
  environment      = var.environment


}


