###
# Output variables list  
# example: https://spacelift.io/blog/terraform-output
###

output "ivrs" {
    value = { for k, ivr in genesyscloud_architect_ivr.all_ivr: k => ivr.id}
}