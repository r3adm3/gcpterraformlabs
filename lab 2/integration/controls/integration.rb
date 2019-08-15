control "pool_public_ip" do
  describe http("http://#{attribute('pool_public_ip')}/") do
    its('status') { should cmp 200 }
    its('body') { should match(/Welcome to Resource [012]/) }
  end
end