

variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "eu-north-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
 
}

variable "container_image" {
  description = "The Docker image for the Strapi application"
}

variable "container_port" {
  description = "The port on which the Strapi container listens"
  default     = 1337
}

variable "hosted_zone_id" {
  type        = string
  description = "Route 53 Hosted Zone ID"
  default     = "Z06607023RJWXGXD2ZL6M" # Replace with your hosted zone ID
}

variable "domain_name" {
  type        = string
  description = "Domain name for the Strapi application"
  default     = "shaikfouziabanu.contentecho.in" # Replace with your subdomain
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  default     = "main"
}

variable "ecs_task_cpu" {
  description = "The amount of CPU units used by the task"
  default     = "256"
}

variable "ecs_task_memory" {
  description = "The amount of memory (in MiB) used by the task"
  default     = "512"
}

variable "ecs_task_desired_count" {
  description = "The desired number of ECS tasks"
  default     = 1
}
