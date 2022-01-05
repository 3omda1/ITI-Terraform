variable "vpc-cidr" {
  type        = string
   default     = "10.0.0.0/16" #in case we didnt specify values in our module
  description = "This is the VPC variable"
}

variable "vpc-tag" {
  type        = string
  default     = "This is the main VPC" #in case we didnt specify values in our module
  description = "description"
}




