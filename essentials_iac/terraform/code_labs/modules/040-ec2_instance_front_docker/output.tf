output "vpc_id" {
  value = data.terraform_remote_state.vpc.outputs.vpc_id
}
output "sg_id" {
  value = data.terraform_remote_state.sg.outputs.sg_id
}

output "ec2_ip" {
  value = aws_instance.web.public_ip
}
