output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_subnets" {
  value = aws_subnet.private_subnets.*.id
}

output "private_subnets_ranges" {
  value = aws_subnet.private_subnets.*.cidr_block
}

output "public_subnets" {
  value = aws_subnet.public_subnets.*.id
}

output "public_subnets_ranges" {
  value = aws_subnet.public_subnets.*.cidr_block
}
