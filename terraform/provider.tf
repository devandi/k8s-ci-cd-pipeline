terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


variable "default_region" {
    type = string
    default = "fra1"
}

variable "do_token" {}


provider "digitalocean" {
  token = var.do_token
}