#!/usr/bin/env bash

# Script to ensure that Replicated running on instance has correct IP,
# it is going to grab the instance private IP and put it in 2 files :
#
#  /etc/default/replicated
#  /etc/default/replicated-operator

INSTANCE_PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

eval "echo \"$(cat replicated.config.tmpl)\"" > /etc/default/replicated
eval "echo \"$(cat replicated-operator.config.tmpl)\"" > /etc/default/replicated-operator

# Enable Replicated
systemctl enable replicated replicated-operator replicated-ui

# Note - we don't need to restart replicated-ui, even if it is already running
systemctl start replicated replicated-operator replicated-ui
echo Waiting for replicated to get online after restart

# Wait for Replicated to load
flag=1
while [ $flag -ne 0 ]
do
  echo .
  sleep 5
  systemctl is-active --quiet service replicated
  flag=${?}
  echo Flag = $flag
done
