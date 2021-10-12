terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.17.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "3.61.0"
    }
  }
}