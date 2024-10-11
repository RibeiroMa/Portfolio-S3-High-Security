terraform {
  backend "s3" {
    bucket = "your_bucket_name"
    key    = "s3.tfstate"
    region = "us-east-1"
  }
}