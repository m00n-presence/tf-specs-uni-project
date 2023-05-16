variable "adr" {type = string}
variable "robot-id" {type = string}

data "yandex_compute_image" "img" {
  family = "container-optimized-image"
}

resource "yandex_compute_instance" "main-vm" {
  name        = "vm-for-app"
  platform_id = "standard-v2"
  zone        = "ru-central1-a"
  service_account_id = var.robot-id

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.img.id
    }
  }

  network_interface {
    subnet_id       = "${yandex_vpc_subnet.subnet-a.id}"
    nat             = true
    nat_ip_address  = var.adr
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    docker-container-declaration = file("${path.module}/declaration.yaml")
    user-data = file("${path.module}/cloud_conf.yaml")
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
