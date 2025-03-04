#!/bin/bash

token='<TOKEN>'

/usr/bin/ansible-pull -o -U "https://x-token-auth:$token@github.com/epomatti/grafana-demo.git"
