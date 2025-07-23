###
# variables list
# note: needs to be declared with every main.tf folder instance
# example: https://www.terraform.io/language/values/variables
###

variable "schedule_groups_id_map" {

  type = map(string)

}