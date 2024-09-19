terraform {
  backend "s3" {
    bucket = "bucket-19-set-2024"
    key    = "terraform/backend"
    region = "us-east-2"
  }
}
