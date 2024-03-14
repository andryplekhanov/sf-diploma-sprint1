# Provider

variable "cloud_id" {
  description = "default cloud_id"
  type        = string
  default     = "b1gdtu6fru13qselq36d"
}

variable "folder_id" {
  description = "default folder_id"
  type        = string
  default     = "b1g27g570jo7mqqbapvm"
}

variable "service_account_key_yandex_admin" {
  type        = string
  default     = "../key.json"
  description = "Local storing service key for admin. Not in git tracking"
}

variable "zone" {
  description = "Use specific availability zone"
  type        = list(string)
  default     = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}