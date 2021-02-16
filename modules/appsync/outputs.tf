output "api_id" {
  value = aws_appsync_graphql_api.appsync_api.id
}

output "api_uris" {
  value = aws_appsync_graphql_api.appsync_api.uris
}

output "api_key" {
  value = aws_appsync_api_key.appsync_api_key.key
}
