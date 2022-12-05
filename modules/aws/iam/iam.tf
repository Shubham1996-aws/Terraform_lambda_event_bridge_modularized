resource "aws_iam_role" "iaac_aws_iam_role" {
  name = "iam_lambda_role_python"
 assume_role_policy = file("../modules/aws/iam/role.tpl")
}

data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "iaac_aws_iam_policy" {
  name        = "iam_lambda_policy_python"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret",
                "secretsmanager:ListSecretVersionIds"
            ],
            "Resource": [
                #"arn:aws:secretsmanager:us-east-1:${data.aws_caller_identity.current.account_id}:secret:*",
               #"arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:*"
               format("arn:aws:secretsmanager:%s:%s:secret:*",
               var.region,
               data.aws_caller_identity.current.account_id
               ) ,
               format ("arn:aws:logs:%s:%s:*",
               var.region,
               data.aws_caller_identity.current.account_id
               )
            ]
        }
    ]

  })
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "lambda-attachment-python"
  roles      = [aws_iam_role.iaac_aws_iam_role.name]
  policy_arn = aws_iam_policy.iaac_aws_iam_policy.arn
}