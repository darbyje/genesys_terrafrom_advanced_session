locals {
  csv_data = file("${path.module}/data-files/routing_skill_group.csv")
}

locals {
  skillgroups = csvdecode(local.csv_data)
  # Split division field into a list, trimming whitespace
  skillgroups_with_divisions = [
    for row in local.skillgroups : merge(row, {
      divisions = [for d in split(",", row.division) : trimspace(d)]
    })
  ]
  # Flatten all division names for lookup
  divisionnames = toset(flatten([
    for row in local.skillgroups_with_divisions : row.divisions
  ]))
}

# Division data set
data "genesyscloud_auth_division" "divisions" {
  for_each = local.divisionnames
  name     = each.key
}

resource "genesyscloud_routing_skill_group" "all_skillgroups" {
  for_each    = { for q in local.skillgroups_with_divisions : q.name => q }
  name        = each.value.name
  description = length(trimspace(each.value.description)) < 1 ? null : each.value.description
  # Use the first division for division_id, or null if none
  division_id = length(each.value.divisions) == 0 ? null : data.genesyscloud_auth_division.divisions[each.value.divisions[0]].id
  # Use all division ids for member_division_ids, or null if none
  member_division_ids = length(each.value.divisions) == 0 ? null : [for d in each.value.divisions : data.genesyscloud_auth_division.divisions[d].id]
  skill_conditions    = each.value.skill_conditions
}
