#!/bin/bash

TERRAFORM_VERSION=0.11.11
KITCHEN_TERRAFORM_VERSION=4.3.0

# Create gems path
cd $HOME
mkdir -p .gems/bin
PATH=$PATH:$HOME/.gems/bin

# Create SSH key
mkdir .ssh
ssh-keygen -t rsa -b 4096 -a 100 -N "" -f .ssh/gcloud_id_rsa

# Install terraform
cd $HOME
mkdir terraform11
cd terraform11
sudo apt-get install unzip
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
cd $HOME
rm -rf terraform11

# Install kitchen-terraform with its dependencies like inspec and test-kitchen
gem install kitchen-terraform -v $KITCHEN_TERRAFORM_VERSION --no-document

# Get email for the GCE default service account
export GCE_EMAIL=$(gcloud iam service-accounts list --format='value(email)' | grep compute)

# Get creds for default CE SA
gcloud iam service-accounts keys create $HOME/.gcloud/Terraform.json --iam-account $GCE_EMAIL

# generate some Env vars
export PROJECT=$(gcloud info --format='value(config.project)')
export TF_VAR_project_name=$PROJECT
