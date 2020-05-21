terraform {
  backend "s3" {
    bucket = "wasanthag-chip-tfe"
    key    = "tfe/tfe-vpc.tfstate"
    region = "us-west-1"
  }
}
