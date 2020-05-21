terraform {
  backend "s3" {
    bucket = "wasanthag-chip-tfe"
    key    = "tfe/tfe-cluster.tfstate"
    region = "us-west-1"
  }
}
