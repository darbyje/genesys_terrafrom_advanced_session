###
# Output variables list  
# example: https://spacelift.io/blog/terraform-output
###

output "schedule_groups" {
  value = { for k, schedule_group in genesyscloud_architect_schedulegroups.all_schedulegroups : k => schedule_group.id }
}