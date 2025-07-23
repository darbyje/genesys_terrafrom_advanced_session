###
# Output variables list  
# example: https://spacelift.io/blog/terraform-output
###

data "genesyscloud_auth_division_home" "home" {}

locals {
    home_division = {
        (data.genesyscloud_auth_division_home.home.name) = data.genesyscloud_auth_division_home.home.id
    }
}

output "divisions" {
    value = merge(local.home_division, { for k, division in genesyscloud_auth_division.divisions: k => division.id })
}