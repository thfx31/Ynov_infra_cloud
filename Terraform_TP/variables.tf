variable "aws_region" {
  description = "La région AWS à utiliser"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_id" {
  description = "L'ID du VPC dans lequel les ressources seront créées"
  type        = string
  default     = "vpc-0035b5ae8bbbefd3f"
}

variable "load_balancer_name" {
  description = "Le nom du Load Balancer"
  type        = string
  default     = "TFX-LoadBalancer"
}

variable "target_group_name" {
  description = "Le nom du Target Group"
  type        = string
  default     = "TFX-TargetGroup"
}

variable "listener_port" {
  description = "Le port du Listener"
  type        = number
  default     = 80
}

variable "ami_id" {
  description = "L'ID de l'image AMI à utiliser pour les instances"
  type        = string
  default     = "ami-0a4186be086b3b6b4"
}

variable "instance_type" {
  description = "Le type d'instance EC2 à utiliser"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Le nom à appliquer aux instances EC2"
  type        = string
  default     = "TFX-instance"
}

variable "launch_template_name_prefix" {
  description = "Le préfixe du nom du Launch Template"
  type        = string
  default     = "TFX-template"
}

variable "desired_capacity" {
  description = "La capacité désirée pour l'Auto Scaling Group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "La capacité maximale pour l'Auto Scaling Group"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "La capacité minimale pour l'Auto Scaling Group"
  type        = number
  default     = 1
}

variable "security_group" {
  description = "Le groupe de sécurité à appliquer"
  type        = string
  default     = "default"
}

variable "tags" {
  description = "Les tags communs à appliquer sur les ressources"
  type        = map(string)
  default     = {
    "Environment" = "Production"
    "Team"        = "Infra"
  }
}
