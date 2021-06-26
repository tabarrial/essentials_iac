resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = data.terraform_remote_state.vpc.outputs.subnet_1a_id
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.sg_id]
  key_name = data.terraform_remote_state.key-ec2.outputs.key_ec2_name

  tags = {
    Name = "velociraptor-ec2-${data.terraform_remote_state.tags.outputs.tg_project}"
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
