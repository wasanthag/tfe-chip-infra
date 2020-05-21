terraform {
  backend "s3" {
    bucket = "wasanthag-chip-tfe"
    key    = "tfe/app-vpc-mesh.tfstate"
    region = "us-west-1"
  }
}
