# Module for creating a datatable off a CSV
locals {
  # Create a map of datatable configurations from the provided CSV files
  datatable_configs = {
    for file in var.csv_files : 
    replace(basename(file), ".csv", "") => {
      name = replace(basename(file), ".csv", "")
      csvfile = "${path.module}/data-files/${file}"
      division = var.division
      description = var.description
    }
  }
}

data "genesyscloud_auth_division" "division" {
  name = var.division
}

resource "genesyscloud_architect_datatable" "datatables" {
  for_each = local.datatable_configs

  name        = each.value.name
  division_id = data.genesyscloud_auth_division.division.id
  description = each.value.description

  dynamic "properties" {
    for_each = csvdecode(file(each.value.csvfile))

    content {
      name    = properties.value.name
      type    = properties.value.type
      title   = properties.value.title == "" ? null : properties.value.title
      default = properties.value.default == "" ? null : properties.value.default
    }
  }
}