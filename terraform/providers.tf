terraform {
  required_version = ">= 0.13"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.108.1"
    }
  }
}

provider "yandex" {
  zone                     = "ru-central1-a"
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = var.service_account_key_yandex_admin
}
