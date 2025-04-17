terraform {
  backend "remote" {
    organization = "your-org-name"

    workspaces {
      name = "vpc-infra"
    }
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  credentials = jsondecode(var.gcp_credentials)
  project     = var.project_id
  region      = var.region
}
