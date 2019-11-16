variable "region" {
  default = "cn-hongkong"
}

# ECS
variable "instance_name" {
  default = "poc"
}

variable "number_format" {
  description = "The number format used to output."
  default     = "%02d"
}

variable "ecs_instance_count" {
  default = 1
}

variable "availability_zone" {
  default = "cn-hongkong-c"
}

variable "internet_max_bandwidth_out" {
  default = "20"
}

variable "key_name" {
  default = "poc"
}

variable "public_key" {
  default = "ssh-rsa xxx"
}

# VPC
variable "cidr_block_vpc" {
  default = "10.0.0.0/18"
}

variable "cidr_block_vswitch" {
  default = "10.0.0.0/20"
}

variable "disk_category" {
  default = "cloud_ssd"
}

variable "disk_size" {
  default = "100"
}

variable "disk_count" {
  default = 1
}
