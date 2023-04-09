#!/bin/bash

sudo yum -y update
yum -y install chrony
sudo systemctl enable chrony
