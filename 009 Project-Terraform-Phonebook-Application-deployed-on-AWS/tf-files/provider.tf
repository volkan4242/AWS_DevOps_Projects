terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.71.0"
    }
    github = {
      source = "integrations/github"
      version = "4.19.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
//  access_key = ""
//  secret_key = ""

}

provider "github" {
  token = "xxxxxxxxxxxxxxxxxx"
}