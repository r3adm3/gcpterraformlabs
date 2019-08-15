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

resource "google_container_cluster" "primary" {
  name               = "gcp-inspec-kube-cluster"
  location           = "us-central1-b"
  initial_node_count = 1

  node_locations = [
    "us-central1-a",
    "us-central1-c",
    "us-central1-f"
  ]

  master_auth {
    username = "gcp-inspec-kube-admin"
    password = "x1@qcSnJ16opo#bzuZ21oofnQ"
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
