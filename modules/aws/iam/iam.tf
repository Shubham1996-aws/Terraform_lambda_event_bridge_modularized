resource "aws_iam_role" "iaac_aws_iam_role" {
  name = "iam_lambda_role_python"
 assume_role_policy = file("../modules/aws/iam/role.tpl")
}

resource "aws_iam_policy" "iaac_aws_iam_policy" {
  name        = "iam_lambda_policy_python"
  policy = file("../modules/aws/iam/policy.json")
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "lambda-attachment-python"
  roles      = [aws_iam_role.iaac_aws_iam_role.name]
  policy_arn = aws_iam_policy.iaac_aws_iam_policy.arn
}