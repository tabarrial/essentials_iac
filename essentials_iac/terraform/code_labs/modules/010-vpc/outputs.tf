output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr_block" {
  value = aws_vpc.this.cidr_block
}

output "subnet_1a_cidr_block" {
  value = aws_subnet.this_1a.cidr_block
}
output "subnet_1a_id" {
  value = aws_subnet.this_1a.id
}

output "subnet_1b_cidr_block" {
  value = aws_subnet.this_1b.cidr_block
}

output "subnet_1b_id" {
  value = aws_subnet.this_1b.id
}

