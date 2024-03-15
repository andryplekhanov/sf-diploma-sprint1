# Variables
# Переменная определяющая токен подключения к облаку яндекс
variable "yandex_cloud_token" {
  description = "Default cloud token in yandex cloud"
  type        = string
  default     = "${token}"
  sensitive   = true
}

# Переменная определяющая id облака, где развернуть ВМ
variable "yandex_cloud_id" {
  description = "Default cloud ID in yandex cloud"
  type        = string
  default     = "${cloud_id}"
}

# Переменная определяющая id папки, где развернуть ВМ
variable "yandex_folder_id" {
  description = "Default folder ID in yandex cloud"
  type        = string
  default     = "${folder_id}"
}