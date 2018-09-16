title 'Retrieve  all GCP Container Cluster Node Pools for a project, cluster and zone'

gcp_project_id = "jjasghar-183117"
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
