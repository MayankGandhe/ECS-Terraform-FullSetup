terraform {
  backend "s3" {
    bucket = "livefurnish-tfstate"
    key    = "application/ecs.tfstate"
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

