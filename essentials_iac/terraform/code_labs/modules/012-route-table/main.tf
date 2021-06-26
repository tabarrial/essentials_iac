resource "aws_route_table" "this" {
    vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        #gateway_id = data.terraform_remote_state.igw.outputs.igw_id
        gateway_id = data.terraform_remote_state.igw.outputs.igw_id
    }

  tags = {
    Name = "route-table-${data.terraform_remote_state.tags.outputs.tg_project}-${data.terraform_remote_state.tags.outputs.tg_enviroment}"
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

resource "aws_main_route_table_association" "this" {
  vpc_id         = data.terraform_remote_state.vpc.outputs.vpc_id
  route_table_id = aws_route_table.this.id
}

