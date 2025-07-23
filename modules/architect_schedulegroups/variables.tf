###
# variables list
# note: needs to be declared with every main.tf folder instance
# example: https://www.terraform.io/language/values/variables
###

variable "schedules_id_map" {

  type = map(string)

}