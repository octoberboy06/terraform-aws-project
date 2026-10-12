# -------------------------
# Public Network ACL
# -------------------------

resource "aws_network_acl" "public" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-nacl"
    Project     = var.project_name
    Environment = var.environment
    Tier        = "public"
    ManagedBy   = "Terraform"
  }
}

resource "aws_network_acl_rule" "public_inbound" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "public_outbound" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_association" "public" {
  for_each = var.public_subnet_ids

  network_acl_id = aws_network_acl.public.id
  subnet_id      = each.value
}


# -------------------------
# Application Network ACL
# -------------------------

resource "aws_network_acl" "app" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-app-nacl"
    Project     = var.project_name
    Environment = var.environment
    Tier        = "app"
    ManagedBy   = "Terraform"
  }
}

resource "aws_network_acl_rule" "app_inbound" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 100
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "app_outbound" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_association" "app" {
  for_each = var.app_subnet_ids

  network_acl_id = aws_network_acl.app.id
  subnet_id      = each.value
}


# -------------------------
# Database Network ACL
# -------------------------

resource "aws_network_acl" "db" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-db-nacl"
    Project     = var.project_name
    Environment = var.environment
    Tier        = "db"
    ManagedBy   = "Terraform"
  }
}

resource "aws_network_acl_rule" "db_inbound" {
  network_acl_id = aws_network_acl.db.id
  rule_number    = 100
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "db_outbound" {
  network_acl_id = aws_network_acl.db.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_association" "db" {
  for_each = var.db_subnet_ids

  network_acl_id = aws_network_acl.db.id
  subnet_id      = each.value
}