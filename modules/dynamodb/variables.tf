variable table_name {
  description = "DynamoDB table name"
  default     = "dynamo-test"
}

variable read_capacity {
  description = "Read capacity"
  default     = 1
}

variable write_capacity {
  description = "Write capacity"
  default     = 1
}
