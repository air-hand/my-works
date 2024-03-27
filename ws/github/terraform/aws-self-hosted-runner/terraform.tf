terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    #bucket         = ""
    key            = "my-works/terraform/aws-self-hosted-runner.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "tf_state_lock"
  }
}
