terraform {
  backend "s3" {
    bucket = "xray-demo-dev-leo-lee-1"
    key    = "terraform.tfstate"
    region = "eu-west-2"
    profile= "sandbox7"
  }
}
