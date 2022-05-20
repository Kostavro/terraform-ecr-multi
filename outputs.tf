output "ecr_repository_names" {
  description = "The names of the repositories"
  value = { for k, v in aws_ecr_repository.this : k => v.name }
}

output "ecr_repository_arns" {
  description = "The ARNs of the repositories"
  value = { for k, v in aws_ecr_repository.this : k => v.arn }
}

output "ecr_repository_registry_ids" {
  description = "The registry IDs where the repositories were created"
  value = { for k, v in aws_ecr_repository.this : k => v.registry_id }
}

output "ecr_repository_urls" {
  description = "The full URLs of the repositories"
  value = { for k, v in aws_ecr_repository.this : k => v.repository_url }
}

output "ecr_repository_tags_all" {
  description = "All of the tags of the repositories"
  value = { for k, v in aws_ecr_repository.this : k => v.tags_all }
}
