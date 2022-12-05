module "lambda_iam" {
  source = "../modules/aws/iam"

}
module "python_function" {
  source = "../modules/aws/python_function"
}
module "lambda_function" {
  source = "../modules/aws/lambda_event"
  schedule_expression = var.schedule_expression
  function_name = var.function_name
  output_path = module.python_function.output_path
  depends_on = [
    module.lambda_iam, module.python_function
  ]
}