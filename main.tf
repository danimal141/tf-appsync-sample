locals {
  project_name         = "test"
  project_name_for_uri = replace(local.project_name, "-", "_")
  datasource_name      = "datasource_${local.project_name_for_uri}"

  dynamodb = {
    table_name = "dynamo-${local.project_name}"
  }

  appsync = {
    name            = "appsync-${local.project_name}"
    datasource_name = local.datasource_name
    resolvers = {
      todo = {
        field       = "todo"
        type        = "Query"
        data_source = local.datasource_name
      }
      add_todo = {
        field       = "addTodo"
        type        = "Mutation"
        data_source = local.datasource_name
      }
    }
  }
}

module "dynamodb" {
  source     = "./modules/dynamodb"
  table_name = local.dynamodb.table_name
}

module "appsync" {
  source            = "./modules/appsync"
  name              = local.appsync.name
  datasource_name   = local.appsync.datasource_name
  dynamo_table_name = module.dynamodb.dynamo_table_name
  dynamo_table_arn  = module.dynamodb.dynamo_table_arn
  resolvers         = local.appsync.resolvers
}
