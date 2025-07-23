locals {
  csv_data = file("${path.module}/data-files/auth_division.csv") #CSV must be a string for csvdecode function to work - so you must read in the file first
}

locals {
  divisions = csvdecode(local.csv_data) #CSV decode will create a map out of the csv string in csv_data
}


resource "genesyscloud_auth_division" "divisions" {
  for_each    = { for q in local.divisions : q.name => q if lower(q.name) != "home" }
  name        = each.value.name
  description = each.value.description
}
