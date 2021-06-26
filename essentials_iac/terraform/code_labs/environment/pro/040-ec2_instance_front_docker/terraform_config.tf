terraform {
  required_version = ">= 0.12"
}

terraform {
  backend "s3" {
    bucket         = "tf-s3-jurassicworld"
    key            = "jurassicworld/pro/040-ec2_instance_front_docker/terraform.tfstate"
    encrypt        = "true"
    dynamodb_table = "pro_state_lock"
  }
}
