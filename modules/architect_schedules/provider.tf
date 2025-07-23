###
# terraform provider 
# note: has to be declared with every main.tf folder instance
# Refrence: https://registry.terraform.io/providers/MyPureCloud/genesyscloud/latest/docs
###

terraform {
  required_providers {
    genesyscloud = {
      source = "mypurecloud/genesyscloud"
    }
  }
}
