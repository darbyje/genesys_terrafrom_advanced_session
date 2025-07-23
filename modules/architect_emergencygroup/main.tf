locals {
  csv_data = file("${path.module}/data-files/architect_emergencygroup.csv") #CSV must be a string for csvdecode function to work - so you must read in the file first
}

locals {
  emergencygroup = csvdecode(local.csv_data) #CSV decode will create a map out of the csv string in csv_data
}

data "genesyscloud_flow" "emergency_flow" {
  for_each = toset([ for group in local.emergencygroup : group.emergency_flow if trimspace(group.emergency_flow) != "" ])
  name = each.key
  type = "INBOUNDCALL"
}

resource "genesyscloud_architect_emergencygroup" "all_emergencygroup" {
  for_each = { for q in local.emergencygroup : q.name => q }

  name = each.value.name
  description = each.value.description
  emergency_call_flows {
    emergency_flow_id = length(trimspace(each.value.emergency_flow)) < 1 ? null : data.genesyscloud_flow.emergency_flow[trimspace(each.value.emergency_flow)].id
    ivr_ids = [for name in split(",", each.value.call_routing): lookup(var.ivrs_id_map, trimspace(name), "")]
  }
}

