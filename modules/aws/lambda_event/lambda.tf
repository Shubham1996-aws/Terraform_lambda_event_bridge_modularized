data "aws_iam_role" "data_aws_iam_role" {
  name = "iam_lambda_role_python"
}

/*data "archive_file" "iaac_archive_file" {
  type        = "zip"
  source_file = "python_function.py"
  output_path = "python_function.zip"
}*/

resource "aws_lambda_function" "iaac_aws_lambda_function" {
  filename      = "../modules/aws/python_function/python_function.zip"
  function_name = var.function_name
  role          = data.aws_iam_role.data_aws_iam_role.arn
  handler       = "python_function.lambda_handler"
  source_code_hash = filebase64sha256(var.output_path)
  runtime = "python3.9"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_rw_fallout_retry_step_deletion_lambda" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.iaac_aws_lambda_function.function_name
  principal = "events.amazonaws.com"
  #source_arn = aws_cloudwatch_event_rule.profile_generator_lambda_event_rule.arn
  source_arn = aws_cloudwatch_event_rule.profile_generator_lambda_event_rule.arn
}