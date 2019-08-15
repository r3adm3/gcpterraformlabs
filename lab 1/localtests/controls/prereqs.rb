title 'prereqs'

describe os_env('CLOUD_SHELL') do
  its('content') { should eq 'true' }
end

describe os_env('GOOGLE_CLOUD_PROJECT') do
  its('content') { should_not be_empty }
end

describe command('terraform -version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /Terraform/ }
end

describe command('kitchen --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /Test Kitchen/ }
end