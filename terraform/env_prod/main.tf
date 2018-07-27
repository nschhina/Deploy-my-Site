terraform {
  backend "s3" {
    bucket         = "my.website.com"
    key            = "terraform.tfstate"
    region         = "us-east-2"
  }
}
