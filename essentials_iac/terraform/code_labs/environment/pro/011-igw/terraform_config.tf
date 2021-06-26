terraform {
  required_version = ">= 0.12"
}

terraform {
  backend "s3" {
    bucket         = "tf-s3-jurassicworld"
    key            = "jurassicworld/pro/011-igw/terraform.tfstate"
    encrypt        = "true"
    #dynamodb_table = "pro_state_lock"
  }
}