# --------------------------------------------------
# Current AWS Account
# --------------------------------------------------

data "aws_caller_identity" "current" {}


# --------------------------------------------------
# Local Values
# --------------------------------------------------

locals {
  github_repo_subject = "repo:${var.github_owner}@${var.github_owner_id}/${var.github_repository}@${var.github_repository_id}"

  terraform_state_bucket = "terraform-aws-project-state-${data.aws_caller_identity.current.account_id}"
}


# --------------------------------------------------
# GitHub OIDC Provider
# --------------------------------------------------

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]
}


# ==================================================
# TERRAFORM PLAN ROLE
# Used by Pull Requests
# ==================================================

data "aws_iam_policy_document" "github_plan_assume_role" {

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.github.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "${local.github_repo_subject}:pull_request"
      ]
    }
  }
}


resource "aws_iam_role" "terraform_plan" {
  name = "GitHubTerraformPlanRole"

  assume_role_policy = data.aws_iam_policy_document.github_plan_assume_role.json
}


# Read-only EC2 permissions for Terraform Plan
resource "aws_iam_role_policy_attachment" "terraform_plan_ec2" {
  role       = aws_iam_role.terraform_plan.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}


# ==================================================
# TERRAFORM APPLY ROLE
# Used only from main branch
# ==================================================

data "aws_iam_policy_document" "github_apply_assume_role" {

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.github.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "${local.github_repo_subject}:ref:refs/heads/main"
      ]
    }
  }
}


resource "aws_iam_role" "terraform_apply" {
  name = "GitHubTerraformApplyRole"

  assume_role_policy = data.aws_iam_policy_document.github_apply_assume_role.json
}


# EC2/VPC permissions for Terraform Apply
resource "aws_iam_role_policy_attachment" "terraform_apply_ec2" {
  role       = aws_iam_role.terraform_apply.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}


# ==================================================
# TERRAFORM REMOTE STATE BUCKET
# ==================================================

resource "aws_s3_bucket" "terraform_state" {
  bucket = local.terraform_state_bucket

  tags = {
    Name      = "Terraform State"
    ManagedBy = "Terraform"
  }

  lifecycle {
    prevent_destroy = true
  }
}


# Enable versioning for Terraform state recovery
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}


# Encrypt Terraform state at rest
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


# Prevent public access to Terraform state
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# ==================================================
# PLAN ROLE - TERRAFORM STATE PERMISSIONS
# ==================================================

data "aws_iam_policy_document" "terraform_plan_state" {

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]

    resources = [
      aws_s3_bucket.terraform_state.arn
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.terraform_state.arn}/dev/terraform.tfstate"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.terraform_state.arn}/dev/terraform.tfstate.tflock"
    ]
  }
}


resource "aws_iam_role_policy" "terraform_plan_state" {
  name   = "TerraformStatePlanAccess"
  role   = aws_iam_role.terraform_plan.id
  policy = data.aws_iam_policy_document.terraform_plan_state.json
}


# ==================================================
# APPLY ROLE - TERRAFORM STATE PERMISSIONS
# ==================================================

data "aws_iam_policy_document" "terraform_apply_state" {

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]

    resources = [
      aws_s3_bucket.terraform_state.arn
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.terraform_state.arn}/dev/terraform.tfstate"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.terraform_state.arn}/dev/terraform.tfstate.tflock"
    ]
  }
}


resource "aws_iam_role_policy" "terraform_apply_state" {
  name   = "TerraformStateApplyAccess"
  role   = aws_iam_role.terraform_apply.id
  policy = data.aws_iam_policy_document.terraform_apply_state.json
}