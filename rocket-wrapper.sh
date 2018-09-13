#!/usr/bin/env bash

set -e

echo "Installing required pips"
pip install docker-py

echo "Starting docket daemon"
systemctl start docker

echo "Running deployment playbook"
ansible-playbook ansible/playbooks/deploy_rockets.yml --connection=local

echo "Running tests"
ansible-playbook ansible/playbooks/test_rockets.yml --connection=local
