terraform {
  backend "s3" {
    bucket         = "mywebdeployment-040324229766-us-east-1"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}
