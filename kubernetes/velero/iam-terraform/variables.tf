variable "region" {
  description = "Amazon Region"
  type = string
  default = "ap-northeast-2"
}

variable "bucket" {
  description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}
