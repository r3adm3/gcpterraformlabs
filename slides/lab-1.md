## Lab 1


Testing your local environment

---

json resource

```ruby
describe json("#{Dir.home}/.gcloud/Terraform.json") do
  its('type') { should eq 'service_account' }
  its(['auth_uri']) { should eq 'https://accounts.google.com/o/oauth2/auth' }
end
```

---

happy output

```bash
Profile: InSpec Profile (localtests)
Version: 0.1.0
Target:  local://

  JSON /home/googlece10626_student/.gcloud/Terraform.json
     ✔  type should eq "service_account"
     ✔  ["auth_uri"] should eq "https://accounts.google.com/o/oauth2/auth"

Test Summary: 2 successful, 0 failures, 0 skipped
```

---

key_rsa resource

```ruby
describe key_rsa("#{Dir.home}/.ssh/gcloud_id_rsa") do
  it { should be_private }
  its('key_length') { should eq 4096 }
end

describe key_rsa("#{Dir.home}/.ssh/gcloud_id_rsa.pub") do
  it { should be_public }
end
```

---

sad output

```bash
Profile: InSpec Profile (localtests)
Version: 0.1.0
Target:  local://

  JSON /home/googlece10626_student/.gcloud/Terraform.json
     ✔  type should eq "service_account"
     ✔  ["auth_uri"] should eq "https://accounts.google.com/o/oauth2/auth"
  rsa_key /home/googlece10626_student/.ssh/gcloud_id_rsa
     ×  passphrase error
  rsa_key /home/googlece10626_student/.ssh/gcloud_id_rsa.pub
     ×  passphrase error

Test Summary: 2 successful, 2 failures, 0 skipped

```
