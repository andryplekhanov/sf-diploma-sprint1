# дефолтная сеть
resource "yandex_vpc_network" "default-net" {
  name = "default-net"
}

# подсеть для сети в зоне a
resource "yandex_vpc_subnet" "mysubnet-a" {
  name           = "mysubnet-a"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = var.zone[0]
  network_id     = yandex_vpc_network.default-net.id
}
