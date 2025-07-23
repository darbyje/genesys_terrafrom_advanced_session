terraform {
  backend "s3" {
    bucket = "genesyspsapac-terraform-state-bucket"
    key    = "org/genesyspsapac/terraform.tfstate"
    region = "ap-southeast-2"
    #   dynamodb_table = "genesyspsapac-terraform-locks"           
    encrypt      = true
    use_lockfile = true #look in to this                 
  }
} 
