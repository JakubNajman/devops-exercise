output db_instance_address {
  description = "IP address of the master database instance"
  value = "${google_sql_database_instance.db.ip_address.0.
    ip_address}"
}
output "db_instance_name" {
  description = "Name of the database instance"
  value = "${google_sql_database_instance.db.name}"
}
output "db_instance_username" {
  description = "Name of the database user" 
  value = "${google_sql_user.postgresql_user.name}"
}
output "db_instance_generated_user_password" {
  description = "The auto generated default user password"
  value = "${random_id.user_password.hex}"
}