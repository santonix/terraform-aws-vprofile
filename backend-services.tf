resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  db_name              = var.dbname
  engine               = "mysql"
  engine_version       = "8.0.35"
  instance_class       = "db.t3.micro"
  username             = var.dbuser
  password             = var.dbpass
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false
  multi_az             = false
  db_subnet_group_name = aws_db_subnet_group.vprofile-rds-subnet-group.name
  vpc_security_group_ids = [ aws_security_group.vprofile-backend-sg.id ]
}

resource "aws_elasticache_cluster" "vprofile-cache" {
  cluster_id           = "vprofile-cache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [ aws_security_group.vprofile-backend-sg.id ]
  subnet_group_name    = aws_elasticache_subnet_group.vprofile-elasticache-subnet-group.name
}

resource "aws_mq_broker" "vprofile-rmq" {
  broker_name          = "vprofile-rmq"
  engine_type          = "ActiveMQ"
  engine_version       = "5.17.6"
  host_instance_type   = "mq.t2.micro"
  security_groups      = [ aws_security_group.vprofile-backend-sg.id ]
  subnet_ids           = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]

  user {
    username = var.rmquser
    password = var.rmqpass
  }
}
