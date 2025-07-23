terraform {
  backend "s3" {
    bucket       = "genesyspsapac-terraform-state-bucket"
    key          = "prod/org/genesyspsapac/terraform.tfstate"
    region       = "ap-southeast-2"
    encrypt      = true
    use_lockfile = true
  }
}
