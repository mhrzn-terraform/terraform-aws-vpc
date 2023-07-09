resource "aws_internet_gateway" "public_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
      var.common_tags,
      {
        Name         = "${var.project_name}-public-igw-${var.env}"
      }
  )  
}

resource "aws_eip" "nat_gw_ips" {
  count = var.multiple_nat_gateway ? var.num_private_subnets : 1
  vpc   = true

  tags = merge(
    var.common_tags,
    {
    Name         = "${var.project_name}-private-nat-gw-ip-${var.region_azs[count.index]}-${var.env}"
    Country      = "all"
    Group        = "${var.project_name}"
    }
  )  
}

resource "aws_nat_gateway" "private_nat_gws" {
  count = var.multiple_nat_gateway ? var.num_private_subnets : 1
  
  allocation_id = aws_eip.nat_gw_ips[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = merge(
    var.common_tags,
    {
    Name         = "${var.project_name}-nat-gw-${var.region_azs[count.index]}-${var.env}"
    Country      = "all"
    Group        = "${var.project_name}"
    }
  )  
  depends_on = [aws_internet_gateway.public_igw]
}