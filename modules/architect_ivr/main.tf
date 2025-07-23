locals {
  csv_data = file("${path.module}/data-files/architect_ivr.csv") #CSV must be a string for csvdecode function to work - so you must read in the file first
}

locals {
  ivrs = csvdecode(local.csv_data) #CSV decode will create a map out of the csv string in csv_data
}

data "genesyscloud_flow" "open_flow" {
  for_each = toset([for ivr in local.ivrs : ivr.open_hours_flow if trimspace(ivr.open_hours_flow) != ""])
  name     = each.key
  type     = "INBOUNDCALL"
}

data "genesyscloud_flow" "closed_flow" {
  for_each = toset([for ivr in local.ivrs : ivr.closed_hours_flow if trimspace(ivr.closed_hours_flow) != ""])
  name     = each.key
  type     = "INBOUNDCALL"
}

data "genesyscloud_flow" "holiday_flow" {
  for_each = toset([for ivr in local.ivrs : ivr.holiday_hours_flow if trimspace(ivr.holiday_hours_flow) != ""])
  name     = each.key
  type     = "INBOUNDCALL"
}

resource "genesyscloud_architect_ivr" "all_ivr" {
  for_each = { for q in local.ivrs : q.name => q }

  name        = each.value.name
  description = each.value.description
  dnis        = [for num in split(",", each.value.dnis) : trimspace(num)]

  open_hours_flow_id    = length(trimspace(each.value.open_hours_flow)) < 1 ? null : data.genesyscloud_flow.open_flow[trimspace(each.value.open_hours_flow)].id
  closed_hours_flow_id  = length(trimspace(each.value.closed_hours_flow)) < 1 ? null : data.genesyscloud_flow.closed_flow[trimspace(each.value.closed_hours_flow)].id
  holiday_hours_flow_id = length(trimspace(each.value.holiday_hours_flow)) < 1 ? null : data.genesyscloud_flow.holiday_flow[trimspace(each.value.holiday_hours_flow)].id
  schedule_group_id     = length(trimspace(each.value.schedule_group)) < 1 ? "" : lookup(var.schedule_groups_id_map, trimspace(each.value.schedule_group), "")
}
