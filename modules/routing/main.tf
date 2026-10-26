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

resource "aws_route_table" "private" {
  count = length(var.private_subnet_ids) > 0 ? 1 : 0

  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.environment}-private-rt"
    Environment = var.environment
    Tier        = "private"
  }
}

resource "aws_route" "private_internet" {
  count = var.enable_nat && length(var.private_subnet_ids) > 0 ? 1 : 0

  route_table_id         = aws_route_table.private[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_id
}

resource "aws_route_table" "app" {
  count = length(var.app_subnet_ids) > 0 ? 1 : 0

  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.environment}-app-rt"
    Environment = var.environment
    Tier        = "app"
  }
}

resource "aws_route" "app_internet" {
  count = var.enable_nat && length(var.app_subnet_ids) > 0 ? 1 : 0

  route_table_id         = aws_route_table.app[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_id
}

resource "aws_route_table" "db" {
  count = length(var.db_subnet_ids) > 0 ? 1 : 0

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

resource "aws_route_table_association" "private" {
  for_each = var.private_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.private[0].id
}

resource "aws_route_table_association" "app" {
  for_each = var.app_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.app[0].id
}

resource "aws_route_table_association" "db" {
  for_each = var.db_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.db[0].id
}