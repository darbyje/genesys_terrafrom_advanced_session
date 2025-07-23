locals {
  csv_data = file("${path.module}/data-files/telephony_did_pool.csv") #CSV must be a string for csvdecode function to work - so you must read in the file first
}

locals {
  did_pools = csvdecode(local.csv_data) #CSV decode will create a map out of the csv string in csv_data
}

resource "genesyscloud_telephony_providers_edges_did_pool" "all_did_pool" {
  for_each = { for q in local.did_pools : q.start_phone_number => q }

  start_phone_number = each.value.start_phone_number
  end_phone_number = each.value.end_phone_number
  description = each.value.service_provider
  comments = each.value.comments
  pool_provider = length(trimspace(each.value.pool_provider)) < 1 ? "PURE_CLOUD" : each.value.pool_provider

}
