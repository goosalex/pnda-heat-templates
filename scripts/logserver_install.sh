#!/bin/bash -v

set -e

export DEBIAN_FRONTEND=noninteractive
apt-get -y install xfsprogs

cat > /etc/salt/grains <<EOF
cloudera:
  cluster_flavour: $flavor$
  role: DATANODE
roles:
  - logserver
pnda_cluster: $pnda_cluster$
EOF

mkfs.xfs $volume_dev$
mkdir -p /var/log/pnda
cat >> /etc/fstab <<EOF
$volume_dev$  /var/log/pnda xfs defaults  0 0
EOF
mount -a

service salt-minion restart
