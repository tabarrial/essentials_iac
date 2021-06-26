resource "aws_security_group" "allow_ports" {
  name        = "allow_ports"
  description = "Allow ports inbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = var.ec2_allow_ports
    content {
      description      = "TLS from VPC"
      from_port        = port.value
      to_port          = port.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${data.terraform_remote_state.tags.outputs.tg_project}"
    service = data.terraform_remote_state.tags.outputs.tg_service
    region = data.terraform_remote_state.tags.outputs.tg_region
    customer = data.terraform_remote_state.tags.outputs.tg_customer
    project = data.terraform_remote_state.tags.outputs.tg_project
    environment = data.terraform_remote_state.tags.outputs.tg_enviroment
    version = data.terraform_remote_state.tags.outputs.tg_version
    provisionedBy = data.terraform_remote_state.tags.outputs.tg_provisionedBy
  }
}
