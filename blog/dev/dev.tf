provider "google" {
  credentials = file("yndcred.json")

  project = var.proj
  region = var.region
  zone = var.zone
}

module "container" {
  source = "./modules/container"
}

module "db" {
  source = "./modules/db"
}

# module "gcn" {
#   source = "./modules/gcn"
# }
