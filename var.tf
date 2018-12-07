variable "aws_access_key" {
  default = "XXXXXXXXXXXX"
}

variable "aws_secret_key" {
  default = "XXXXXXXXXXXXXXXXXXX"
}

variable "aws_region" {
  default = "us-east-2"
}

variable "WIN_AMIS" {
  type =  "map" 
    default = {
      us-east-2  = "ami-09d7f402df5fd27aa"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub" 
}

variable "INSTANCE_USERNAME" {
  default = "administrator"
}

variable "INSTANCE_PASSWORD" {
  default = "redhat"
}
