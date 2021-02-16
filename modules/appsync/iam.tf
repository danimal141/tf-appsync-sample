data "aws_iam_policy_document" "role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["appsync.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_role" {
  name               = "${var.name}-role"
  assume_role_policy = data.aws_iam_policy_document.role.json
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:Scan",
    ]
    resources = [
      var.dynamo_table_arn,
    ]
  }
}

resource "aws_iam_role_policy" "ima_role_policy" {
  name   = "${var.name}-policy"
  role   = aws_iam_role.iam_role.id
  policy = data.aws_iam_policy_document.policy.json
}
