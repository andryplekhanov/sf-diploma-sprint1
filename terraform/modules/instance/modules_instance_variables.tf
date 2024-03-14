variable "instance_family_image" {
  description = "Instance image"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "vpc_subnet_id" {
  description = "VPC subnet network id"
  type        = string
}

variable "yandex_folder_id" {
  description = "yc_folder_id"
  type        = string
}

variable "zone" {
  description = "default zone"
  type        = string
}

variable "name" {
  description = "default name for instance"
  type        = string
  default     = "instance"
}

variable "username" {
  description = "default username for instance's user"
  type        = string
  default     = "ubuntu"
}

variable "cores" {
  description = "default cores number"
  type        = number
  default     = 4
}

variable "memory" {
  description = "default memory number"
  type        = number
  default     = 12
}

variable "core_fraction" {
  description = "default core_fraction number"
  type        = number
  default     = 100
}

variable "is_preemptible" {
  description = "default is_preemptible"
  type        = bool
  default     = false
}

variable "nat" {
  description = "default nat"
  type        = bool
  default     = true
}
