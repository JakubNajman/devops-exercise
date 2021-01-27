provider "google" {
  credentials = file("yndcred.json")

  project = var.proj
  region = var.region
  zone = var.zone
}

provider "google-beta" {
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
  network = module.gcn.network
}

module "gcn" {
  source = "./modules/gcn"
}

