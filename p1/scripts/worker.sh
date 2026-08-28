#!/bin/bash

set -e

apt-get update -y
apt-get install -y curl

# Wait until server has generated the token
while [ ! -f /vagrant/node-token ]; do
  echo "Waiting for K3s server token..."
  sleep 2
done

TOKEN=$(cat /vagrant/node-token)

curl -sfL https://get.k3s.io | \
  K3S_URL=https://192.168.56.110:6443 \
  K3S_TOKEN="$TOKEN" \
  sh -s - agent \
  --node-ip 192.168.56.111

#removing token after copying it
rm -f /vagrant/node-token
