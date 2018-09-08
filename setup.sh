#!/bin/bash

# Create bin path
cd $HOME
mkdir bin
PATH=$PATH:$HOME/bin/

# Install terraform
cd $HOME
mkdir terraform11
cd terraform11
sudo apt-get install unzip
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip terraform_0.11.7_linux_amd64.zip
mv terraform $HOME/bin/.
cd $HOME
rm -rf terraform11
