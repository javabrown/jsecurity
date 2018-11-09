variable "aws_region" {
  type = "string"
  default = "us-east-1"
}

//variable "aws_access_key_id" {}
//variable "aws_secret_access_key" {}

variable "aws_zones" {
  type        = "list"
  description = "List of availability zones to use"
//  default     = ["us-east-1a", "us-east-1b"] --RAJA COmment - It was creating two instance - chnaged to create one bellow
  default     = ["us-east-1a"]
}

variable "aws_access_key" {
  type = "string"
  default = "xxxxxxxxxxxxxxx"
}

variable "aws_access_id" {
  type = "string"
  default = "xxxxxxxxxxxxxxxxxxxxx"
}