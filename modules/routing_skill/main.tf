locals {
  csv_data = file("${path.module}/data-files/routing_skill.csv") #CSV must be a string for csvdecode function to work - so you must read in the file first
}

locals {
  skills = csvdecode(local.csv_data) #CSV decode will create a map out of the csv string in csv_data
}

resource "genesyscloud_routing_skill" "all_skills" {
  for_each = { for q in local.skills : q.name => q }

  name = each.value.name
}
