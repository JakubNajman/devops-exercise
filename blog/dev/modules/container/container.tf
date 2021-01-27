provider "google" {
  credentials = file("yndcred.json")

  project = var.proj
  region = var.region
  zone = var.zone
}

data "google_client_config" "provider" {}

resource "google_container_cluster" "primary" {
    name = var.cluster
    location = var.region
    node_locations = var.zones
    description = "Glowny kontener naszej aplikacji."
    remove_default_node_pool = true
    initial_node_count =1

    network    = "vpc-network"
    subnetwork = "vpc-network"

    ip_allocation_policy {
        cluster_ipv4_cidr_block  = "/16"
        services_ipv4_cidr_block = "/22"
  }
}

resource "google_container_node_pool" "primary_preemptible_node" {
    name = "yndblog-node-pool"
    location = var.region
    cluster = google_container_cluster.primary.name
    node_count = 1
    
    node_config {
      preemptible = true
      machine_type = var.machine_type

      service_account = "yndblog@yndblog.iam.gserviceaccount.com"
      oauth_scopes = [
          "https://www.googleapis.com/auth/cloud-platform",
          "https://www.googleapis.com/auth/logging.write",
          "https://www.googleapis.com/auth/monitoring"
      ]
    }
}

provider "kubernetes" {
    load_config_file = false
    ###
    host = "https://${google_container_cluster.primary.endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
        google_container_cluster.primary.master_auth[0].cluster_ca_certificate,
    )
}