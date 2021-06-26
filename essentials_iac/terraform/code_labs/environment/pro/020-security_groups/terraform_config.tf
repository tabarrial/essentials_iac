terraform {
  required_version = ">= 0.12"
}

terraform {
  backend "s3" {
    bucket         = "tf-s3-jurassicworld"
    key            = "jurassicworld/pro/020-security_groups/terraform.tfstate"
    encrypt        = "true"
    dynamodb_table = "pro_state_lock"
  }
}
