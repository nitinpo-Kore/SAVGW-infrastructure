#!/bin/bash

if [ "$1" == "yes" ]; then 

INFLUXDB_IP=$2

cd /tmp
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
gpg --with-fingerprint --show-keys ./influxdata-archive_compat.key
cat <<EOF | sudo tee /etc/yum.repos.d/influxdb.repo
[influxdb]
name = InfluxDB Repository - RHEL 
baseurl = https://repos.influxdata.com/rhel/8/x86_64/stable/
enabled = 1
gpgcheck = 0
gpgkey = https://repos.influxdata.com/influxdb.key
EOF

sudo yum -y update
sudo yum -y install telegraf


sudo cp /tmp/telegraf.conf /etc/telegraf/telegraf.conf

sudo systemctl enable telegraf
sudo systemctl start telegraf

fi