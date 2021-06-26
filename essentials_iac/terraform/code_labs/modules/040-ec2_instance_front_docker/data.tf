data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket         = "tf-s3-jurassicworld"
    key            = "jurassicworld/pro/010-vpc/terraform.tfstate"
    encrypt        = "true"
    dynamodb_table = "pro-tf-state-lock"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket         = "tf-s3-jurassicworld"
    key            = "jurassicworld/pro/020-security_groups/terraform.tfstate"
    encrypt        = "true"
    dynamodb_table = "pro-tf-state-lock"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "terraform_remote_state" "tags" {
  backend = "s3"
  config = {
    bucket         = "tf-s3-jurassicworld"
    key            = "jurassicworld/pro/002-tags/terraform.tfstate"
    encrypt        = "true"
    dynamodb_table = "pro-state-lock"
  }
}

data "terraform_remote_state" "key-ec2" {
  backend = "s3"
  config = {
    bucket         = "tf-s3-jurassicworld"
    key            = "jurassicworld/pro/003-key-ec2/terraform.tfstate"
    encrypt        = "true"
    dynamodb_table = "pro-tf-state-lock"
  }
}
