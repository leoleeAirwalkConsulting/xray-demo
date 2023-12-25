module "lambda_function_1" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "xray-demo-function-1"
  description   = "lambda function 1 for X-ray demo"
  handler       = "handler.lambda_handler"
  runtime       = "python3.11"
 
  source_path = {
    path     = "../py_src/function1/handler.py",
    patterns = [
      "!.venv/.*"
    ]
  }

  layers = [
    module.lambda_function_1_layer.lambda_layer_arn,
  ]

  attach_policy_json = true
  policy_json        = <<-EOT
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "dynamodb:PutItem"
                ],
                "Resource": ["*"]
            }
        ]
    }
  EOT

  attach_tracing_policy = true
  tracing_mode = "Active"

  tags = {
    Name = "xray-demo-function-1"
  }
}

module "lambda_function_1_layer" {
  source = "terraform-aws-modules/lambda/aws"

  create_layer = true
  create_function = false
  layer_name          = "xray-demo-function-1-layer"

  compatible_runtimes = ["python3.11"]
 
  source_path = {
    path     = "../py_src/function1/requirements.txt",
    pip_requirements = true
    prefix_in_zip = "python"
    patterns = [
      "!.venv/.*"
    ]
  }
  runtime       = "python3.11"

  tags = {
    Name = "xray-demo-function-1-layer"
  }
}