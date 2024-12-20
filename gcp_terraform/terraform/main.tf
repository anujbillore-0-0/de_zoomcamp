terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.14.1"
    }
  }
}

provider "google" {
  credentials = "./keys/my-creds.json"
  project = "luminous-wharf-445218-t0"
  region  = "us-central1"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "luminous-wharf-445218-t0-terra-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}