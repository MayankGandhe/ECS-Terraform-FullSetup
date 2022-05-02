resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_policy"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeNetworkInterfaces"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}
resource "aws_iam_role" "lambda_role" {
  name                = "lambda_iam"
  managed_policy_arns = [aws_iam_policy.lambda_policy.arn]
  assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "livefurnish_lambda" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  filename      = "python.zip"
  function_name = "livefurnish_lambda_${var.environment}"
  role          = aws_iam_role.lambda_role.arn
  handler       = "test.lambda_handler"
  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  runtime = "python3.8"
  vpc_config {
    # Every subnet should be able to reach an EFS mount target in the same Availability Zone. Cross-AZ mounts are not permitted.
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [aws_security_group.sg_for_lambda.id]
  }

}

module "Load_Balancer_lambda" {
  source         = "./Load_Balancer"
  lBSubnet       = module.vpc.public_subnets
  ecsClusterName = var.ecsClusterName
  tags           = var.tags
  port           = var.containerPort
  vpc_id         = module.vpc.vpc_id
  app_name       = "lambda"
  environment    = var.environment
  isLambda       = true


}
resource "aws_security_group" "sg_for_lambda" {
  name        = "inboud_lambda"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Inbound from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_lb_target_group_attachment" "main" {
  target_group_arn = module.Load_Balancer_lambda.tgARN
  target_id        = aws_lambda_function.livefurnish_lambda.arn
  depends_on       = [aws_lambda_permission.allow_alb_to_invoke_lambda]
}
resource "aws_lambda_permission" "allow_alb_to_invoke_lambda" {
  statement_id  = "AllowExecutionFromALB"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.livefurnish_lambda.function_name
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = module.Load_Balancer_lambda.tgARN
}