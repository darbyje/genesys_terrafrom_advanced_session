locals {
  csv_data = file("${path.module}/data-files/flow_outcome.csv") #CSV must be a string for csvdecode function to work - so you must read in the file first
}

locals {
  outcomes = csvdecode(local.csv_data) #CSV decode will create a map out of the csv string in csv_data
}


resource "genesyscloud_flow_outcome" "outcomes" {
  for_each = { for q in local.outcomes : q.name => q }
  name     = each.value.name
  description = each.value.description
}
