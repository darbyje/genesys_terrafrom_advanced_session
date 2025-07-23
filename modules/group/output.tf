###
# Output variables list  
# example: https://spacelift.io/blog/terraform-output
###

output "groups" {
  value = { for k, group in genesyscloud_group.all_groups : k => group.id }
}