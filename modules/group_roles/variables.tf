###
# variables list
# note: needs to be declared with every main.tf folder instance
# example: https://www.terraform.io/language/values/variables
###

variable "groups_id_map" {
  description = "Map of group names to their IDs"
  type        = map(string)
}