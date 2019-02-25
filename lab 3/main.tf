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

variable "gcp_project_name" {
  default = "" # go here https://console.cloud.google.com/home/dashboard Under Project Info
}
variable "gcp_project_id" {
  default = "" # Under Project Info
}
variable "gcp_project_number" {
  default = "" # Under Project Info
}

variable "gcp_kube_cluster_name" {
  default = "gcp-inspec-kube-cluster"
}
variable "gcp_kube_cluster_zone" {
  default = "us-central1-b"
}
variable "gcp_kube_cluster_zone_extra1" {
  default = "us-central1-a"
}
variable "gcp_kube_cluster_zone_extra2" {
  default = "us-central1-c"
}
variable "gcp_kube_cluster_master_user" {
  default = "gcp-inspec-kube-admin"
}
variable "gcp_kube_cluster_master_pass" {
  default = "x1@qcSnJ16opo#bzuZ21oofnQ"
}


resource "google_container_cluster" "primary" {
  project = "${var.gcp_project_id}"
  name               = "${var.gcp_kube_cluster_name}"
  zone               = "${var.gcp_kube_cluster_zone}"
  initial_node_count = 3

  additional_zones = [
    "${var.gcp_kube_cluster_zone_extra1}",
    "${var.gcp_kube_cluster_zone_extra2}",
  ]

  master_auth {
    username = "${var.gcp_kube_cluster_master_user}"
    password = "${var.gcp_kube_cluster_master_pass}"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
