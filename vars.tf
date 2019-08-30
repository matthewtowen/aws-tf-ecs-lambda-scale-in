variable "file_name" {
  description = "This is the filename of the .zip containing the function"
  type        = "string"
  default     = ""
}
variable "name" {
  description = "The cluster name, e.g df"
  default = ""
}

variable "environment" {
  description = "Environment tag, e.g prod"
  default = ""
}
