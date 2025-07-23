###
# Output variables list  
# example: https://spacelift.io/blog/terraform-output
###

output "wrapup_codes" {
    value = { for k, wrap_code in genesyscloud_routing_wrapupcode.wrapup_codes: k => wrap_code.id}
}