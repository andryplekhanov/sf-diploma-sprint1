# Создание сервисной ВМ и развертывание с неё kubernetes кластера
module "kubernetes_cluster" {
  source           = "./modules/instance"
  vpc_subnet_id    = yandex_vpc_subnet.mysubnet-a.id
  name             = "srv"
  zone             = var.zone[0]
  yandex_folder_id = var.folder_id
}