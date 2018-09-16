gcp_project = ENV["PROJECT"]

control 'gcp-firewalls-no-ftp' do
  title 'Ensure no FTP allowed in firewall rules'
  google_compute_firewalls(project: gcp_project).firewall_names.each do |firewall_name|
    describe google_compute_firewall(project: gcp_project, name: firewall_name, source_ranges: ["0.0.0.0/0"]) do
      it { should exist }
      it { should_not allow_port_protocol("21", "tcp")}
    end
  end
end
