provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Terraform = "aws-self-hosted-runner"
    }
  }
}
