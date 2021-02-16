data "local_file" "graphql_schema" {
  filename = "modules/appsync/resources/schema.graphql"
}

resource "aws_appsync_graphql_api" "appsync_api" {
  name                = var.name
  authentication_type = "API_KEY"
  schema              = data.local_file.graphql_schema.content
}

resource "aws_appsync_api_key" "appsync_api_key" {
  api_id = aws_appsync_graphql_api.appsync_api.id
}

resource "aws_appsync_datasource" "appsync_datasource" {
  api_id           = aws_appsync_graphql_api.appsync_api.id
  name             = var.datasource_name
  service_role_arn = aws_iam_role.iam_role.arn
  type             = "AMAZON_DYNAMODB"

  dynamodb_config {
    table_name = var.dynamo_table_name
  }
}

data "local_file" "resolver_requests" {
  for_each = var.resolvers
  filename = "modules/appsync/resources/templates/${each.key}/request.tmpl"
}

data "local_file" "resolver_responses" {
  for_each = var.resolvers
  filename = "modules/appsync/resources/templates/${each.key}/response.tmpl"
}

resource "aws_appsync_resolver" "appsync_resolver" {
  for_each    = var.resolvers
  api_id      = aws_appsync_graphql_api.appsync_api.id
  field       = lookup(each.value, "field")
  type        = lookup(each.value, "type")
  data_source = lookup(each.value, "data_source")

  request_template  = lookup(data.local_file.resolver_requests, each.key).content
  response_template = lookup(data.local_file.resolver_responses, each.key).content

  caching_config {
    caching_keys = [
      "$context.identity.sub",
      "$context.arguments.id"
    ]
    ttl = 60
  }
}
