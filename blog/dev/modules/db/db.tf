resource "google_sql_database_instance" "db" {
    name = "postgres-db-instance-${random_id.db_name_suffix.hex}"
    database_version = "POSTGRES_13"
    region = var.region
    deletion_protection = false

    settings {
        tier = "db-f1-micro"

        ip_configuration {
        ipv4_enabled = false
        # authorized_networks {
        #     value = "0.0.0.0/0"
        #     }
        private_network = var.network
        }

    }

}

resource "random_id" "db_name_suffix" {
    byte_length = 4
}

resource "google_sql_database" "postgres-db" {
    name = "postgres-db"
    project = var.proj
    instance = "${google_sql_database_instance.db.name}"
}

resource "random_id" "user_password" {
    byte_length = 8
}

resource "google_sql_user" "postgresql_user" {
    name = "blog_backend"
    project = var.proj
    instance = "${google_sql_database_instance.db.name}"
    password = "${random_id.user_password.hex}"
}