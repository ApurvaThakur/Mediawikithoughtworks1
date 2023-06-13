terraform {
  backend "s3" {
    bucket         = "s3-bucket-terraform-mediawikiinfra"
    key            = "terraform-aws-eks.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}
