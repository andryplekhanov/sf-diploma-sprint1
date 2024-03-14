# дефолтная сеть
resource "yandex_vpc_network" "default-net" {
  name = "default-net"
}

# подсеть для сети в зоне a
resource "yandex_vpc_subnet" "mysubnet-a" {
  name           = "mysubnet-a"
  v4_cidr_blocks = ["10.5.0.0/16"]
  zone           = var.zone[0]
  network_id     = yandex_vpc_network.default-net.id
}

# подсеть для сети в зоне b
resource "yandex_vpc_subnet" "mysubnet-b" {
  name = "mysubnet-b"
  v4_cidr_blocks = ["10.6.0.0/16"]
  zone           = var.zone[1]
  network_id     = yandex_vpc_network.default-net.id
}