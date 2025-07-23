locals {
  csv_data = file("${path.module}/data-files/routing_wrapupcode.csv") #CSV must be a string for csvdecode function to work - so you must read in the file first
}

locals {
  wrapupcodes   = csvdecode(local.csv_data) #CSV decode will create a map out of the csv string in csv_data
  divisionnames = toset([for row in local.wrapupcodes : row.division if trimspace(row.division) != ""])
}

data "genesyscloud_auth_division" "divisions" {
  for_each = local.divisionnames
  name     = each.key
}


resource "genesyscloud_routing_wrapupcode" "wrapup_codes" {
  for_each    = { for q in local.wrapupcodes : q.name => q }
  name        = each.value.name
  division_id = length(trimspace(each.value.division)) < 1 ? "*" : data.genesyscloud_auth_division.divisions[trimspace(each.value.division)].id
}
