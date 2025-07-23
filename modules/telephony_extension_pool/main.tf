locals {
  csv_data = file("${path.module}/data-files/telephony_extension_pool.csv") #CSV must be a string for csvdecode function to work - so you must read in the file first
}

locals {
  extension_pools = csvdecode(local.csv_data) #CSV decode will create a map out of the csv string in csv_data
}

resource "genesyscloud_telephony_providers_edges_extension_pool" "all_extension_pool" {
  for_each = { for q in local.extension_pools : q.start_number => q }

  start_number = each.value.start_number
  end_number = each.value.end_number
  description = each.value.description

}
