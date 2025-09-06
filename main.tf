data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

terraform {
  required_version = ">=1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region // Utilisation de la variable
  profile = "projet1-sso"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.5.0"

  name = "${var.project_name}-VPC-${terraform.workspace}" // Nom du VPC par environnement
  cidr = var.vpc_cidr_block

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  # # enable_nat_gateway = terraform.workspace == "prod" ? true : false // NAT Gateway uniquement en prod
  # single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.common_tags # Tags communs définis dans locals.tf
}

# Appel de notre module local 'instance_web'
module "serveur_web" {
  source = "./modules/instance_web" # Chemin vers notre module

  project_name    = var.project_name
  environment_tag = terraform.workspace                         // Utilise directement le nom du workspace
  instance_type   = local.current_instance_config.instance_type // Depuis locals.tf
  ami_id          = data.aws_ami.amazon_linux_2023.id
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.public_subnets[0]
}

# data "aws_ami" "amazon_linux_2023" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["al2023-ami-*-kernel-*-x86_64"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }
# }

# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }

# provider "aws" {
#   region  = var.aws_region // Utilisation de la variable
#   profile = "projet1-sso"
# }

# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"
#   # Consultez le Terraform Registry pour la dernière version stable et compatible (ex: ~> 5.0)
#   version = "~> 5.5.0" # IMPORTANT: Spécifiez et vérifiez la version !

#   name = "${var.project_name}-VPC"
#   cidr = var.vpc_cidr_block # Utilise la variable définie dans variables.tf racine

#   azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"] # Exemple pour 3 AZs
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]                      # Exemple de CIDRs pour sous-réseaux privés
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]                # Exemple de CIDRs pour sous-réseaux publics

#   enable_nat_gateway = false # Crée une NAT Gateway pour les sous-réseaux privés (peut engendrer des coûts)
#   single_nat_gateway = true # Utilise une seule NAT Gateway pour toutes les AZs (réduit les coûts)

#   enable_dns_hostnames = true
#   enable_dns_support   = true

#   tags = {
#     ManagedBy = "Terraform"
#     Environment = var.environment_tag
#     Project     = var.project_name
#   }
# }

# # Appel de notre module local 'instance_web'
# module "serveur_web" {
#   source = "./modules/instance_web" # Chemin vers notre module

#   ami_id          = data.aws_ami.amazon_linux_2023.id
#   instance_type   = var.instance_type # Utilise la variable définie dans le variables.tf racine
#   project_name    = var.project_name
#   environment_tag = var.environment_tag
#   subnet_id       = module.vpc.public_subnets[0] # Utilise le premier sous-réseau public du module VPC
#   vpc_id          = module.vpc.vpc_id            # Utilise l'ID du VPC créé par le module VPC
# }
# Vous pourriez même appeler le module une seconde fois pour créer un autre serveur !
# module "serveur_web_2" {
#   source = "./modules/instance_web"
#
#   ami_id        = data.aws_ami.amazon_linux_2023.id
#   instance_type = "t3.small" # Type différent
#   project_name  = var.project_name
#   environment_tag = "Staging" # Environnement différent
# }