
variable "aws_region" {
  description = "La région AWS où les ressources seront déployées."
  type        = string
  default     = "eu-west-3"
}

# variable "instance_type" {
#   description = "Le type d'instance EC2 à utiliser pour le serveur web."
#   type        = string
#   default     = "t2.micro"

#   validation {
#     condition     = contains(["t2.micro", "t2.small", "t3.micro", "t3.small"], var.instance_type)
#     error_message = "Le type d'instance doit être t2.micro, t2.small, t3.micro, ou t3.small."
#   }
# }

variable "project_name" {
  description = "Nom du projet, utilisé pour le taggage des ressources."
  type        = string
  default     = "Projet1-IaC"
}

// Remplacé par les variables declarées dans le fichier locales.tf
# variable "environment_tag" {
#   description = "Tag d'environnement (ex: Development, Staging, Production)."
#   type        = string
#   default     = "Development"
#   validation {
#     condition     = length(var.environment_tag) > 0
#     error_message = "Le tag d'environnement ne peut pas être vide."
#   }
# }


variable "vpc_cidr_block" {
  description = "Le bloc CIDR pour le VPC principal."
  type        = string
  default     = "10.0.0.0/16"
}
// premier fichier avant le module 
# variable "aws_region" {
#   description = "La région AWS où les ressources seront déployées."
#   type        = string
#   default     = "us-east-1"
# }

# variable "instance_type" {
#   description = "Le type d'instance EC2 à utiliser pour le serveur web."
#   type        = string
#   default     = "t2.micro"

#   validation {
#     condition     = contains(["t2.micro", "t2.small", "t3.micro", "t3.small"], var.instance_type)
#     error_message = "Le type d'instance doit être t2.micro, t2.small, t3.micro, ou t3.small."
#   }
# }

# variable "project_name" {
#   description = "Nom du projet, utilisé pour le taggage des ressources."
#   type        = string
#   default     = "Projet1-IaC"
# }

# variable "environment_tag" {
#   description = "Tag d'environnement (ex: Development, Staging, Production)."
#   type        = string
#   default     = "Development"
#   validation {
#     condition     = length(var.environment_tag) > 0
#     error_message = "Le tag d'environnement ne peut pas être vide."
#   }
# }