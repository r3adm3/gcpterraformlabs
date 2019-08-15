gcp_project = ENV["GOOGLE_CLOUD_PROJECT"]
control 'gcp-firewalls-no-ftp' do
  title 'Ensure no FTP allowed in firewall rules'
  google_compute_firewalls(project: gcp_project).firewall_names.each do |firewall_name|
    next if firewall_name == "default-allow-internal"
    describe google_compute_firewall(project: gcp_project, name: firewall_name) do
      it { should_not allow_port_protocol("21", "tcp")}
    end
  end
end