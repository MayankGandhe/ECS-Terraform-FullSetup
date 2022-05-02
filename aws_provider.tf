terraform {
  backend "s3" {
    bucket = "BUCKET_NAME"
    key    = "KEY_NAME"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  type        = string
  description = "AWS region where you want to deploy the infrastructure"
}

