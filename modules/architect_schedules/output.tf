###
# Output variables list  
# example: https://spacelift.io/blog/terraform-output
###

output "schedules" {
  value = { for k, schedule in genesyscloud_architect_schedules.all_schedules : k => schedule.id }
}