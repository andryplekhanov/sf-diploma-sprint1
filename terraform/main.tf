# Создание сервисной ВМ и развертывание с неё kubernetes кластера
module "kubernetes_cluster" {
  source           = "./modules/srv"
  vpc_subnet_id    = yandex_vpc_subnet.mysubnet-a.id
  name             = "srv"
  zone             = var.zone[0]
  yandex_folder_id = var.folder_id
  yandex_cloud_id  = var.cloud_id
  yandex_token     = var.yandex_cloud_token
}