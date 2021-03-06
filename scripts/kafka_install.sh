#!/bin/bash -v

set -e

cat > /etc/salt/grains <<EOF
roles:
  - kafka
pnda_cluster: $pnda_cluster$
broker_id: $brokerid$
EOF

export DEBIAN_FRONTEND=noninteractive
apt-get -y install xfsprogs

mkfs.xfs $volume_dev$
mkdir -p /var/log/pnda
cat >> /etc/fstab <<EOF
$volume_dev$  /var/log/pnda xfs defaults  0 0
EOF
mount -a

service salt-minion restart
