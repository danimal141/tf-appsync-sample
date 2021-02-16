variable name {
  description = "GraphQL API name"
  default     = "appsync-test"
}

variable datasource_name {
  description = "Datasource name"
  default     = "appsync-test"
}

variable resolvers {
  description = "Resolvers for AppSync"
}

variable dynamo_table_arn {
  description = "DynamoDB table arn"
}

variable dynamo_table_name {
  description = "DynamoDB table name"
  default     = "appsync-test"
}
