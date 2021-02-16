resource "aws_dynamodb_table" "dynamo_table" {
  name           = var.table_name
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
