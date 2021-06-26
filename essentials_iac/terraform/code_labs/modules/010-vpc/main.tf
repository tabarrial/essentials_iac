resource "aws_vpc" "this" {
    assign_generated_ipv6_cidr_block = false
    cidr_block = var.vpc_cidr
    enable_classiclink = false
    enable_classiclink_dns_support = false
    enable_dns_hostnames = true
    enable_dns_support = true

  tags = {
    Name = "main-vpc-${data.terraform_remote_state.tags.outputs.tg_project}"
    service = data.terraform_remote_state.tags.outputs.tg_service
    backup = data.terraform_remote_state.tags.outputs.tg_backup
    scheduledPowerOff = data.terraform_remote_state.tags.outputs.tg_scheduledPowerOff
    region = data.terraform_remote_state.tags.outputs.tg_region
    customer = data.terraform_remote_state.tags.outputs.tg_customer
    project = data.terraform_remote_state.tags.outputs.tg_project
    environment = data.terraform_remote_state.tags.outputs.tg_enviroment
    version = data.terraform_remote_state.tags.outputs.tg_version
    security = data.terraform_remote_state.tags.outputs.tg_security
    analyzed = data.terraform_remote_state.tags.outputs.tg_analyzed
    encrypted = data.terraform_remote_state.tags.outputs.tg_encrypted
    provisionedBy = data.terraform_remote_state.tags.outputs.tg_provisionedBy
  }

}

resource "aws_subnet" "this_1a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnet_vpc_cidr_1a
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "this_1b" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnet_vpc_cidr_1b
  availability_zone = "eu-north-1b"
}
