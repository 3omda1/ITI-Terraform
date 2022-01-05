variable "ami-name" {
  type = string
}

variable "instance-type-name" {
  type = string
}
variable "subnet-id" {
}

variable "create-ec2" {
  type    = bool
  default = true

}


