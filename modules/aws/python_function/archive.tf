data "archive_file" "iaac_archive_file" {
  type        = "zip"
  source_file = "../modules/aws/python_function/python_function.py"
  output_path = "../modules/aws/python_function/python_function.zip"
}
output "output_path" {
  value = data.archive_file.iaac_archive_file.output_path
}