resource "aws_dynamodb_table" "state_lock" {
  name           = var.state_lock_table_name
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
