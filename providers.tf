terraform {
  backend "s3" {
    bucket         = "poc1-ecs-s3-bucket"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
  }
}
 
provider "aws" {
  region = "ap-south-1"
}
