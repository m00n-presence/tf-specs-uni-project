// данная сеть импортируется командой terraform input
// так как у Яндекс Облака есть лимиты на максимальное количество сетей
resource "yandex_vpc_network" "net" {
  name        = "default"
  description = "Импортированная сеть в спецификацию TF"
}

resource "yandex_vpc_subnet" "subnet-a" {
  name           = "subnet0"
  v4_cidr_blocks = ["10.131.0.0/24"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.net.id}"
}
