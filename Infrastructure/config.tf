terraform {
  backend "s3" {
    bucket = "lucidify-tf-state"
    key = "lucidify-state"
    region = "us-east-1"
    secret_key = "REMOVED"
    access_key = "REMOVED"
  }
}
