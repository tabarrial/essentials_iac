data "terraform_remote_state" "tags" {
  backend = "s3"
  config = {
    bucket         = "tf-s3-jurassicworld"
    key            = "jurassicworld/pro/002-tags/terraform.tfstate"
    encrypt        = "true"
    dynamodb_table = "pro-tf-state-lock"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket         = "tf-s3-jurassicworld"
    key            = "jurassicworld/pro/010-vpc/terraform.tfstate"
    encrypt        = "true"
    dynamodb_table = "pro-tf-state-lock"
  }
}
