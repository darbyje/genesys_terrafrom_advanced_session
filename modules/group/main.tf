locals {
  csv_data = file("${path.module}/data-files/group.csv") #CSV must be a string for csvdecode function to work - so you must read in the file first
}

locals {
  groups             = csvdecode(local.csv_data) #CSV decode will create a map out of the csv string in csv_data
  owner_email        = flatten([for group in local.groups : [for email in split(",", trimspace(group.owner_email)) : trimspace(email) if trimspace(email) != ""]])
  unique_owner_email = toset(local.owner_email)

  member_email        = flatten([for group in local.groups : [for email in split(",", trimspace(group.member_email)) : trimspace(email) if trimspace(email) != ""]])
  unique_member_email = toset(local.member_email)
}

data "genesyscloud_user" "group_owner" {
  for_each = local.unique_owner_email
  email    = each.key
}

data "genesyscloud_user" "group_member" {
  for_each = local.unique_member_email
  email    = each.key
}

resource "genesyscloud_group" "all_groups" {
  for_each    = { for q in local.groups : q.name => q }
  name        = each.value.name
  description = each.value.description
  type        = lower(each.value.type)
  visibility  = lower(each.value.visibility)
  owner_ids   = [for email in split(",", trimspace(each.value.owner_email)) : data.genesyscloud_user.group_owner[trimspace(email)].id if trimspace(email) != ""]
  member_ids  = [for email in split(",", trimspace(each.value.member_email)) : data.genesyscloud_user.group_member[trimspace(email)].id if trimspace(email) != ""]

  lifecycle {
    ignore_changes = [
      owner_ids,
      member_ids
    ]
  }
}
