###CLUSTER VARIABLES###
variable "proj" {
    default = "yndblog"
}

variable "region" {
    default = "europe-north1"
}

variable "zone" {
    default = "europe-north1-a"
}

variable "zones" {
    default = ["europe-north1-a", "europe-north1-c"]
}

variable "cluster" {
    default = "yndblog-cluster"
}

variable "machine_type" {
    default = "g1-small"
}