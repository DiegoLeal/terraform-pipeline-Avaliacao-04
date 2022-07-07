variable "aws_region" {
  type        = string
  description = ""
  default     = "us-east-1"
}

variable "instance_ami" {
  type        = string
  description = ""
  default     = "ami-0729e439b6769d6ab"
}

variable "instance_type" {
  type        = string
  description = ""
  default     = "t2.micro"
}

variable "key_name" {
  type = string
  description = ""
  default = "terraform"
} 


variable "cidrs_acesso_remoto" {
  type        = list(any)
  description = ""
  default     = ["0.0.0.0/0"]
}

