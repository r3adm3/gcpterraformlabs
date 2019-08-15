gcp_project = ENV["GOOGLE_CLOUD_PROJECT"]
control "default_firewall" do
  describe google_compute_firewall(project: gcp_project, name: 'tf-www-firewall') do
    its('allowed_http?')  { should be true }
    it { should allow_ip_ranges ["0.0.0.0/0"] }
  end
end