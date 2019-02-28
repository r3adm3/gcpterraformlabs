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

# Install terraform
url=https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo sh -c "curl -s $url | gunzip > /usr/local/bin/terraform"
sudo chmod +x /usr/local/bin/terraform

# Install kitchen-terraform with its dependencies like inspec and test-kitchen
sudo gem install kitchen-terraform -v ${KITCHEN_TERRAFORM_VERSION} --no-document
