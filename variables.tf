variable "repositories" {
  description = "A map of repositories with their configuration"
  type        = any
}

variable "default_image_tag_mutability" {
  description = "Default image tag mutability. Accepted values are MUTABLE or IMMUTABLE"
  type        = string
  default     = "IMMUTABLE"
}

variable "default_tags" {
  description = "Tags to apply by default to the ECR repository"
  type        = map(any)
  default     = null
}

variable "default_scan_on_push" {
  description = "Whether to enable scan on push by default on images of the ECR repository"
  type        = bool
  default     = true
}

variable "default_encryption_configuration_type" {
  description = "Default encryption configuration for the ECR repository"
  type        = string
  default     = "AES256"
}

variable "default_encryption_configuration_key" {
  description = "Default encryption configuration for the ECR repository"
  type        = string
  default     = ""
}

variable "default_lifecycle_policy" {
  description = "Default lifecycle policy for the ECR repository"
  type        = string
  default     = <<EOF
{
  "rules" : [
    {
      "rulePriority" : 1,
      "description" : "Keep last 30 images",
      "selection" : {
        "tagStatus" : "any",
        "countType" : "imageCountMoreThan",
        "countNumber" : 30
      },
      "action" : {
        "type" : "expire"
      }
    }
  ]
}
EOF
}

variable "default_permissions_policy" {
  description = "Default permissions policy for the ECR repository"
  type        = string
  default     = <<EOF
{
  "Version" : "2008-10-17",
  "Statement" : [
    {
      "Sid" : "",
      "Effect" : "Allow",
      "Action" : "ecr:PutImage",
      "Principal" : {
        "AWS" : "*"
      }
    }
  ]
}
EOF
}
