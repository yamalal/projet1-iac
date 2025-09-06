output "web_server_public_ip" {
  description = "Adresse IP publique de l'instance EC2 NGINX."
  value       = module.serveur_web.public_ip # Référence la sortie du module
}

output "web_server_instance_id" {
  description = "ID de l'instance EC2 NGINX."
  value       = module.serveur_web.instance_id # Référence la sortie du module
}

output "vpc_id_from_module" {
  description = "ID du VPC créé par le module distant."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids_from_module" {
  description = "Liste des IDs des sous-réseaux publics créés par le module VPC."
  value       = module.vpc.public_subnets
}

output "private_subnet_ids_from_module" {
  description = "Liste des IDs des sous-réseaux privés créés par le module VPC."
  value       = module.vpc.private_subnets
}


// first file for outputs
# output "s3_bucket_name" {
#   description = "Nom du bucket S3 créé pour le backend Terraform."
#   value       = aws_s3_bucket.tfstate.bucket
# }

# # output "dynamodb_table_name" {
# #   description = "Nom de la table DynamoDB créée pour le verrouillage de l'état Terraform."
# #   value       = aws_dynamodb_table.terraform_locks.name
# # }

# output "web_server_public_ip" {
#   description = "Adresse IP publique de l'instance EC2 NGINX. Accédez via http://<IP_PUBLIQUE>"
#   value       = aws_instance.web_server.public_ip
# }

# output "web_server_instance_id" {
#   description = "ID de l'instance EC2 NGINX."
#   value       = aws_instance.web_server.id
# }

# output "web_security_group_id" {
#   description = "ID du groupe de sécurité pour le serveur web NGINX."
#   value       = aws_security_group.web_sg.id
# }