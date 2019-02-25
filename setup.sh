#!/bin/bash
#
# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
