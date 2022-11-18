terraform {
  required_version = ">1.0.5"
  required_providers {

    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAJTTSSUF2PB6HDCCA"
  secret_key = "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"
}