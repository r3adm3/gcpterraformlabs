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

title 'Retrieve  all GCP Container Cluster Node Pools for a project, cluster and zone'

gcp_project_id = ENV['GOOGLE_CLOUD_PROJECT']
gcp_kube_cluster_name = "gcp-inspec-kube-cluster"
gcp_kube_cluster_zone = "us-central1-b"

control 'gcp-container-cluster-node-pools-1.0' do

  impact 1.0
  title 'Ensure container cluster node pools have the correct properties in bulk.'

  describe google_container_clusters(project: gcp_project_id, zone: gcp_kube_cluster_zone) do
    it { should exist }
    its('count') { should be <= 10}
    its('cluster_names') { should include gcp_kube_cluster_name }
    its('cluster_statuses') { should include "RUNNING" }
  end
end
