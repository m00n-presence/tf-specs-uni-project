resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = var.robot-id
  description        = "Статический ключ доступа для Object Storage"
}

resource "yandex_storage_bucket" "storage-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  # original name "nopaperus"
  bucket = "nopaperus1"
  max_size = 5368709120
  anonymous_access_flags {
    read = true
    list = false
    config_read = false
  }
}
