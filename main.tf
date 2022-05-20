resource "aws_ecr_repository" "this" {
  for_each = { for key, value in var.repositories : key => value }

  name                 = each.key
  image_tag_mutability = lookup(each.value, "image_tag_mutability", var.default_image_tag_mutability)
  tags                 = lookup(each.value, "tags", var.default_tags)

  image_scanning_configuration {
    scan_on_push = lookup(each.value, "scan_on_push", var.default_scan_on_push)
  }

  encryption_configuration {
    encryption_type = lookup(each.value, "encryption_type", var.default_encryption_configuration_type)
    kms_key         = lookup(each.value, "encryption_key", var.default_encryption_configuration_key)
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each = { for key, value in var.repositories : key => value }

  repository = each.key
  policy     = lookup(each.value, "lifecycle_policy", var.default_lifecycle_policy)

  depends_on = [aws_ecr_repository.this]
}

resource "aws_ecr_repository_policy" "this" {
  for_each = { for key, value in var.repositories : key => value }

  repository = each.key
  policy     = lookup(each.value, "permissions_policy", var.default_permissions_policy)

  depends_on = [aws_ecr_repository.this]
}
