#!/bin/bash

token='<TOKEN>'

/usr/bin/ansible-pull -o -U "https://x-token-auth:$token@epomatti/grafana-demo.git"
