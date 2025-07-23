locals {
  flow_division_map = {
    "Terraform Flow A" = "Home",
    "Terraform Flow B" = "Terraform Division",
    "Terraform Flow C" = "Terraform Division B"
  }
  common_module_hash = filesha256("${path.module}/data-files/commonModules/Terraform CM_v1-0.yaml")
  inbound_flow_hash  = filesha256("${path.module}/data-files/inboundCall/Terraform Inbound Flow_v1-0.yaml")
}

resource "genesyscloud_flow" "iterable_flows" {
  for_each = local.flow_division_map
  filepath = "${path.module}/data-files/inboundCall/Terraform Inbound Flow_v1-0.yaml"
  file_content_hash = join(":", [
    local.inbound_flow_hash,
    local.common_module_hash
  ])

  depends_on = [genesyscloud_flow.common_modules]

  substitutions = {
    flow_name = each.key
    division  = each.value
  }
}

resource "genesyscloud_flow" "common_modules" {
  filepath = "${path.module}/data-files/commonModules/Terraform CM_v1-0.yaml"
  file_content_hash = join(":", [
    local.common_module_hash,
    local.inbound_flow_hash
  ])
}

