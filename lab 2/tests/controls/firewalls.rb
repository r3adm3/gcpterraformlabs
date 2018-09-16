gcp_project = ENV["PROJECT"]

control 'gcp-firewalls-no-ftp' do
  title 'Ensure no FTP allowed in firewall rules'
  google_compute_firewalls(project: gcp_project).firewall_names.each do |firewall_name|
    describe google_compute_firewall(project: gcp_project, name: firewall_name) do
      it { should exist }
      its('allow_port_protocol(port: "21", protocol: "tcp")?')  { should be false }
    end
  end
end
