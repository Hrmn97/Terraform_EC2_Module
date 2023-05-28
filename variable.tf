variable "ami_id" {
  description = "ami Id for the instance"
  type        = string
  default     = "ami-1234567890"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "associate_public_ip" {
  type    = bool
  default = true
}

variable "disable_api_termination" {
  type    = bool
  default = false
}

variable "volume_size" {
  type    = number
  default = 8
}

variable "application" {
  type    = string
  default = "main"
}
variable "organization" {
  type    = string
  default = "main"
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "ports" {
  type = list(number)
}
