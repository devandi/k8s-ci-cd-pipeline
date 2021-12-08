resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = "do-challenge"
  region  = var.default_region
  version = "1.21.5-do.0"
 
  node_pool {
    name       = "autoscale-worker-pool"
    size       = "s-2vcpu-4gb"
    auto_scale = true
    min_nodes = 1
    max_nodes = 2
  }
}

resource "digitalocean_container_registry" "do-challenge-registry" {
  name                   = "do-challenge-registry"
  subscription_tier_slug = "starter"
}

