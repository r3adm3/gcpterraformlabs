#!/bin/bash

# Create gems path
cd $HOME
mkdir -p .gems/bin
PATH=$PATH:$HOME/.gems/bin

# Create SSH key
mkdir .ssh
ssh-keygen -t rsa -N "" -f .ssh/gcloud_id_rsa


# Install terraform
cd $HOME
mkdir terraform11
cd terraform11
sudo apt-get install unzip
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip terraform_0.11.7_linux_amd64.zip
sudo mv terraform /usr/local/bin/
cd $HOME
rm -rf terraform11

# Install inspec, test-kitchen, kitchen-terraform
gem install inspec --no-ri --no-rdoc
gem install inspec-iggy --no-ri --no-rdoc
gem install test-kitchen --no-ri --no-rdoc
gem install kitchen-terraform --no-ri --no-rdoc

# Create Terraform service account
gcloud iam service-accounts create terraform --display-name terraform-sa
export TERRAFORM_SA_EMAIL=$(gcloud iam service-accounts list \
    --filter="displayName:terraform-sa" \
    --format='value(email)')

export GCE_EMAIL=$(gcloud iam service-accounts list --format='value(email)' | grep compute)
export PROJECT=$(gcloud info --format='value(config.project)')
export TF_VAR_project_name=$PROJECT

# Give Terraform SA and GCE default SA roles/owner IAM permissions
gcloud projects add-iam-policy-binding $PROJECT --role roles/owner --member serviceAccount:$TERRAFORM_SA_EMAIL
gcloud projects add-iam-policy-binding $PROJECT --role roles/owner --member serviceAccount:$GCE_EMAIL
gcloud projects add-iam-policy-binding $PROJECT --role roles/owner --member user:$(gcloud config list account --format "value(core.account)")

# Get creds for Terraform SA
gcloud iam service-accounts keys create $HOME/.gcloud/Terraform.json --iam-account $TERRAFORM_SA_EMAIL


