terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.23.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "3.62.0"
    }
  }
}