locals {
  csv_data = file("${path.module}/data-files/architect_schedulegroups.csv") #CSV must be a string for csvdecode function to work - so you must read in the file first
}

locals {
  schedulegroups = csvdecode(local.csv_data) #CSV decode will create a map out of the csv string in csv_data
  divisionnames  = toset([for row in local.schedulegroups : row.division])
}

data "genesyscloud_auth_division" "divisions" {
  for_each = toset(local.divisionnames)
  name     = each.key
}

resource "genesyscloud_architect_schedulegroups" "all_schedulegroups" {
  for_each = { for q in local.schedulegroups : q.name => q }

  name                 = each.value.name
  description          = each.value.description
  time_zone            = each.value.time_zone
  division_id          = length(trimspace(each.value.division)) < 1 ? null : data.genesyscloud_auth_division.divisions[each.value.division].id
  open_schedules_id    = compact([for schedule_name in split(",", each.value.open_schedules) : lookup(var.schedules_id_map, trimspace(schedule_name), null)])
  closed_schedules_id  = compact([for schedule_name in split(",", each.value.closed_schedules) : lookup(var.schedules_id_map, trimspace(schedule_name), null)])
  holiday_schedules_id = compact([for schedule_name in split(",", each.value.holiday_schedules) : lookup(var.schedules_id_map, trimspace(schedule_name), null)])
}
