locals {
  csv_data = file("${path.module}/data-files/architect_schedules.csv") #CSV must be a string for csvdecode function to work - so you must read in the file first
}

locals {
  schedules = csvdecode(local.csv_data) #CSV decode will create a map out of the csv string in csv_data
}

resource "genesyscloud_architect_schedules" "all_schedules" {
  for_each = { for q in local.schedules : q.name => q }

  name  = each.value.name
  start = each.value.start
  end   = each.value.end
  rrule = length(trimspace(each.value.rrule)) < 1 ? null : each.value.rrule
}
