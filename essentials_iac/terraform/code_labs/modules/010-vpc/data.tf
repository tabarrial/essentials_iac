data "terraform_remote_state" "tags" {
  backend = "s3"
  config = {
    bucket         = "tf-s3-jurassicworld"
    key            = "jurassicworld/pro/002-tags/terraform.tfstate"
    encrypt        = "true"
    dynamodb_table = "pro-state-lock"
  }
}
