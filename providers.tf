terraform {
  backend "s3" {
    bucket         = "my-ecs-s3-bucket"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
  }
}
 
provider "aws" {
  region = "ap-south-1"
}
