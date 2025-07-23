locals {
  csv_data = file("${path.module}/data-files/flow_milestone.csv") #CSV must be a string for csvdecode function to work - so you must read in the file first
}

locals {
  milestones = csvdecode(local.csv_data) #CSV decode will create a map out of the csv string in csv_data
}


resource "genesyscloud_flow_milestone" "all_milestones" {
  for_each    = { for q in local.milestones : q.name => q }
  name        = each.value.name
  description = each.value.description
}
