variable "cloudid" {type = string}
variable "folder" {type = string}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  #token     = "" use the SA of this VM
  cloud_id  = var.cloudid
  folder_id = var.folder
  zone      = "ru-central1-a"
}
