#
# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# See https://cloud.google.com/compute/docs/load-balancing/network/example

provider "google" {
  region      = "us-central1"
  zone        = "us-central1-f"
}

resource "google_compute_http_health_check" "default" {
  name                = "tf-www-basic-check"
  request_path        = "/"
  check_interval_sec  = 1
  healthy_threshold   = 1
  unhealthy_threshold = 10
  timeout_sec         = 1
}

resource "google_compute_target_pool" "default" {
  name          = "tf-www-target-pool"
  instances     = ["${google_compute_instance.www.*.self_link}"]
  health_checks = ["${google_compute_http_health_check.default.name}"]
}

resource "google_compute_forwarding_rule" "default" {
  name       = "tf-www-forwarding-rule"
  target     = "${google_compute_target_pool.default.self_link}"
  port_range = "80"
}

resource "google_compute_instance" "www" {
  count = 3

  name         = "tf-www-${count.index}"
  machine_type = "f1-micro"
  tags         = ["www-node"]

  boot_disk {
    initialize_params {
      image = "family/ubuntu-1404-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Ephemeral
    }
  }

  metadata_startup_script = <<EOS
#!/bin/bash -xe

apt-get -y update
apt-get -y install nginx
IP=$(curl -s -H "Metadata-Flavor:Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip)
echo "Welcome to Resource ${count.index} - tf-www-${count.index} ($IP)" > /usr/share/nginx/html/index.html
service nginx start
  EOS

  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
}

resource "google_compute_firewall" "default" {
  name    = "tf-www-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["www-node"]
}
