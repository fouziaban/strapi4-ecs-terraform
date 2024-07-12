# Create Application Load Balancer
resource "aws_lb" "strapi" {
  name               = "strapi-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.Alb_sg.id]
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id  ]

  enable_deletion_protection = false
}

# Create Target Group
resource "aws_lb_target_group" "strapi" {
  name        = "strapi-targets"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.kartik_vpc.id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# Create Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.strapi.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.strapi.arn
  }
}