data "yandex_compute_image" "my_image" {
  family = var.instance_family_image
}

# Service accounts
# Создание сервисного аккаунта в яндекс облаке для кластера srv ноды
resource "yandex_iam_service_account" "admin-sf" {
  name = "admin-sf"
}

# Назначаем права созданного аккаунта
resource "yandex_resourcemanager_folder_iam_member" "admin-sf" {
  folder_id = var.yandex_folder_id
  role = "admin"
  member = "serviceAccount:${yandex_iam_service_account.admin-sf.id}"
  depends_on = [
    yandex_iam_service_account.admin-sf,
  ]
}

# Создаем ключи доступа Static Access Keys
resource "yandex_iam_service_account_static_access_key" "static-access-key" {
  service_account_id = yandex_iam_service_account.admin-sf.id
  depends_on = [
    yandex_iam_service_account.admin-sf,
  ]
}

# Compute instance for service
# Создаём ВМ - srv сервисную ноду, с которой будет просиходить развёртывание кластера k8s, мониторинг, логирование и процессы CI/CD
resource "yandex_compute_instance" "srv" {
  name        = var.name
  zone        = var.zone
  hostname    = var.name
  platform_id = "standard-v3"

  resources {
    cores         = var.cores
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
      size     = 30
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = var.nat
  }

  scheduling_policy {
    preemptible = var.is_preemptible
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.username}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("~/.ssh/id_rsa.pub")}"
    ssh-keys = "${var.username}:${file("~/.ssh/id_rsa.pub")}"
  }
}