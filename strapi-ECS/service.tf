resource "aws_ecs_service" "strapi" {
  name            = "strapi-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.kartik-strapi.arn
  desired_count   = var.ecs_task_desired_count
  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1

  }

  network_configuration {
    subnets          = [aws_subnet.public1.id , aws_subnet.public2.id]
    security_groups  = [aws_security_group.kartik_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.strapi.arn
    container_name   = "strapi"
    container_port   = var.container_port
  }
}



