resource "aws_cloudwatch_event_rule" "profile_generator_lambda_event_rule" {
  name = "profile-generator-lambda-event-rule-python"
  description = "retry scheduled every 1 min"
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "profile_generator_lambda_target" {
  arn = aws_lambda_function.iaac_aws_lambda_function.arn
  rule = aws_cloudwatch_event_rule.profile_generator_lambda_event_rule.name
}