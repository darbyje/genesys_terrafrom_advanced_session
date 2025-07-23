locals {
  csv_data = file("${path.module}/data-files/group_roles.csv")
  groups   = csvdecode(local.csv_data)
}

locals {
  # Parse roles and divisions from the CSV
  parsed_roles = [for group in local.groups : {
    group_name = group.name
    group_id   = lookup(var.groups_id_map, group.name, "")
    roles = [
      for role_entry in split("|", group.roles_division) : {
        role_name = regex("^([^\\[]+)", trimspace(role_entry))[0]
        divisions = regex("\\[(.*)\\]", trimspace(role_entry))[0] == "*" ? ["*"] : split(";", regex("\\[(.*)\\]", trimspace(role_entry))[0])
      }
    ]
  }]

  # Get unique role names for data source lookup
  unique_roles = distinct(flatten([
    for group in local.parsed_roles : [
      for role in group.roles : role.role_name
    ]
  ]))

  # Get unique division names (excluding "*")
  unique_divisions = distinct(flatten([
    for group in local.parsed_roles : [
      for role in group.roles : [
        for div in role.divisions : div if div != "*"
      ]
    ]
  ]))
}

data "genesyscloud_auth_role" "all_roles" {
  for_each = toset(local.unique_roles)
  name     = each.key
}

data "genesyscloud_auth_division" "divisions" {
  for_each = toset(local.unique_divisions)
  name     = each.key
}

resource "genesyscloud_group_roles" "all_group_roles" {
  for_each = { for item in local.parsed_roles : item.group_name => item }

  group_id = each.value.group_id

  dynamic "roles" {
    for_each = each.value.roles

    content {
      role_id = data.genesyscloud_auth_role.all_roles[roles.value.role_name].id
      division_ids = roles.value.divisions[0] == "*" ? ["*"] : [
        for div in roles.value.divisions : data.genesyscloud_auth_division.divisions[trimspace(div)].id
      ]
    }
  }
}
