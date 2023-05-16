variable "name-of-db" {type = string}
variable "db-username" {type = string}
variable "db-pass" {type = string}

resource "yandex_mdb_mysql_database" "db-res" {
  cluster_id = yandex_mdb_mysql_cluster.dbcluster.id
  name       = var.name-of-db
}

resource "yandex_mdb_mysql_user" "db-admin" {
    cluster_id = yandex_mdb_mysql_cluster.dbcluster.id
    name       = var.db-username
    password   = var.db-pass

    permission {
      database_name = var.name-of-db
      roles         = ["ALL"]
    }
}

resource "yandex_mdb_mysql_cluster" "dbcluster" {
  name        = "papersql"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.net.id
  version     = "8.0"

  resources {
    resource_preset_id = "b2.nano"
    disk_type_id       = "network-hdd"
    disk_size          = 10
  }

  mysql_config = {
    sql_mode                      = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
    max_connections               = 100
    default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
    innodb_print_all_deadlocks    = true
  }

  host {
    zone             = "ru-central1-a"
    subnet_id        = yandex_vpc_subnet.subnet-a.id
    assign_public_ip = false
  }

  access {
    data_lens     = false
    web_sql       = true
    data_transfer = false
  }
}
