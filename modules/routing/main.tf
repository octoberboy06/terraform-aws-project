resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name        = "${var.environment}-public-rt"
    Environment = var.environment
    Tier        = "public"
  }
}

resource "aws_route_table" "app" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.environment}-app-rt"
    Environment = var.environment
    Tier        = "app"
  }
}

resource "aws_route" "app_internet" {
  count = var.nat_gateway_id != null ? 1 : 0

  route_table_id         = aws_route_table.app.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_id
}

resource "aws_route_table" "db" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.environment}-db-rt"
    Environment = var.environment
    Tier        = "db"
  }
}

resource "aws_route_table_association" "public" {
  for_each = var.public_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "app" {
  for_each = var.app_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.app.id
}

resource "aws_route_table_association" "db" {
  for_each = var.db_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.db.id
}

