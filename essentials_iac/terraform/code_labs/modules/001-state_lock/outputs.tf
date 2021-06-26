output "state_lock" {
  value       = aws_dynamodb_table.state_lock.id
  description = "Environment state lock"
}
