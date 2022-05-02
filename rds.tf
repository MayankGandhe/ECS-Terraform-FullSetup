resource "aws_db_instance" "mydb1" {
  allocated_storage       = 256 # gigabytes
  backup_retention_period = 7   # in days
  db_subnet_group_name    = aws_db_subnet_group.default.name
  engine                  = "postgres"
  engine_version          = "13.4"
  identifier              = "mydb1"
  instance_class          = var.instance_class
  multi_az                = false
  db_name                 = "livefurnish_db"
  password                = var.db-password
  port                    = 5432
  publicly_accessible     = false
  storage_encrypted       = true # you should always do this
  storage_type            = "gp2"
  username                = "postgres"
  vpc_security_group_ids  = [aws_security_group.allow_rds.id]
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_security_group" "allow_rds" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
output "rds_endpoint" {

  value = aws_db_instance.mydb1.endpoint
}

resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id        = "redis-${var.environment}"
  engine            = "redis"
  node_type         = "cache.t3.micro"
  num_cache_nodes   = 1
  port              = 6379
  apply_immediately = true
  subnet_group_name = "${var.environment}-cache-subnet"
  depends_on = [
    aws_elasticache_subnet_group.redis_group
  ]

}

resource "aws_elasticache_subnet_group" "redis_group" {
  name       = "${var.environment}-cache-subnet"
  subnet_ids = module.vpc.private_subnets
}
output "redis_endpoint" {
  value = aws_elasticache_cluster.redis_cluster.cache_nodes

}