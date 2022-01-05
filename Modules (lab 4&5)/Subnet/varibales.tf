
# variable "sub-public1-cidr" {
    
# }

variable "vpc-id" {

}

variable "private-subnet" {
  type = list
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

variable "puplic-subnet-tag" {
  type        = string
  default     = "This is the tag from main root subnet directory"
 
}




