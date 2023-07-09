resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.common_tags,
    {
      Name       = "${var.project_name}-rt-public-${var.env}"
      SubnetType = "public"
    }
  )
}

resource "aws_route_table" "private_route_table" {
  count  = var.multiple_nat_gateway ? var.num_private_subnets : 1
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.common_tags,
    {
      Name       = "${var.project_name}-rt-private-${var.region_azs[count.index]}-${var.env}"
      SubnetType = "private"
    }
  )
}

resource "aws_route_table_association" "public_rt_assoc" {
  count          = var.num_public_subnets
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_rt_assoc" {
  count          = var.num_private_subnets
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = var.multiple_nat_gateway ? aws_route_table.private_route_table[count.index].id : aws_route_table.private_route_table[0].id
}

resource "aws_route" "rt_public_egress" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.public_igw.id
}

resource "aws_route" "rt_private_egress" {
  count                  = var.multiple_nat_gateway ? var.num_private_subnets : 1
  route_table_id         = aws_route_table.private_route_table[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.private_nat_gws[count.index].id
}
