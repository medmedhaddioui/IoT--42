#!/bin/bash

set -e

apt-get update -y
apt-get install -y curl

curl -sfL https://get.k3s.io | sh -s - server \
  --node-ip 192.168.56.110 \
  --disable traefik \
  --disable servicelb \
  --disable metrics-server \
  --disable local-storage

# Wait for K3s server token to exist
while [ ! -f /var/lib/rancher/k3s/server/node-token ]; do
  sleep 2
done

# Copy token somewhere Vagrant can share with worker
cp /var/lib/rancher/k3s/server/node-token /vagrant/node-token
chmod 644 /vagrant/node-token
