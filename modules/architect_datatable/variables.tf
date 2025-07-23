###
# variables list
# note: needs to be declared with every main.tf folder instance
# example: https://www.terraform.io/language/values/variables
###

variable "division" {
  description = "The division name for the datatable"
  type        = string
}

variable "description" {
  description = "The description for the datatable"
  type        = string
  default     = ""
}

variable "csv_files" {
  description = "List of CSV files to create datatables from"
  type        = list(string)
}