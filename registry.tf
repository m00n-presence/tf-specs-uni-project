resource "yandex_container_registry" "reg" {
  name      = "paper1"
}

resource "yandex_container_registry_iam_binding" "pull-cr" {
  registry_id = yandex_container_registry.reg.id
  role        = "container-registry.images.puller"

  members = [
    "system:allUsers",
  ]
}

resource "yandex_container_registry_iam_binding" "view-cr" {
  registry_id = yandex_container_registry.reg.id
  role        = "viewer"

  members = [
    "system:allUsers"
  ]
}

resource "yandex_container_repository" "repo" {
  name = "${yandex_container_registry.reg.id}/paper1"
}
