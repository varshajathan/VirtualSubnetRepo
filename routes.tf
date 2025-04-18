resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  region  = var.region
  network = google_compute_network.custom_vpc.id
}

resource "google_compute_router_nat" "nat_config" {
  name                               = "nat-config"
  router                             = google_compute_router.nat_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_route" "default_internet" {
  name        = "default-internet-route"
  network     = google_compute_network.custom_vpc.name
  dest_range  = "0.0.0.0/0"              # ✅ Correct attribute
  next_hop_gateway = "default-internet-gateway"  # ✅ Correct for default IGW
  priority    = 1000
}

