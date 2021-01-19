resource "google_compute_network" "vpc_network" {
    name = "vpc-network"
    auto_create_subnetworks = false
    mtu = 1500
    project = var.proj
}

resource "google_compute_subnetwork" "blog_subnetwork" {
  name          = "blog-subnetwork"
  region        = var.region
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = "10.10.0.0/16"
}

resource "google_compute_global_address" "private_postgresql_connection_impl" {
  name = "postgresql-private-ip-adress"
  purpose = "VPC_PEERING"
  address_type = "INTERNAL"
  prefix_length = 16
  network = "${google_compute_network.vpc_network.name}"
}

resource "google_service_networking_connection" "private_postgresql_connection" {
    network = "${google_compute_network.vpc_network.self_link}"
    service = "servicenetworking.googleapis.com"
    reserved_peering_ranges = [ "${google_compute_global_address.private_postgresql_connection_impl.name}" ]
}