terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

data "aws_subnets" "existing" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_security_group" "default" {
  vpc_id = var.vpc_id
  filter {
    name   = "group-name"
    values = [var.security_group]
  }
}

resource "aws_lb" "main" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.default.id]
  subnets            = data.aws_subnets.existing.ids
}

resource "aws_lb_target_group" "main" {
  name        = var.target_group_name
  port        = var.listener_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_launch_template" "main" {
  name_prefix   = var.launch_template_name_prefix
  image_id      = var.ami_id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [data.aws_security_group.default.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, {
      Name = var.instance_name
    })
  }
}

resource "aws_autoscaling_group" "main" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = data.aws_subnets.existing.ids
  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.main.arn]

  tag {
    key                 = "Name"
    value               = var.instance_name
    propagate_at_launch = true
  }
}
