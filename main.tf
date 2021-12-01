terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "devday-2"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}


