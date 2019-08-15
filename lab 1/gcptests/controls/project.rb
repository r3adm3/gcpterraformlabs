title 'GCP project'

gcp_project = ENV['GOOGLE_CLOUD_PROJECT']

describe google_project(project: gcp_project) do
  it { should exist }
  its('project_id') { should eq gcp_project }
  its('lifecycle_state') { should eq 'ACTIVE' }
end