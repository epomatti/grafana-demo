# Grafana Demo

Grafana Alloy deployment on a Linux host.

## Create the Linux Host

```sh
mkdir -p vagrant/grafana-demo
cd vagrant/grafana-demo

vagrant init ubuntu/jammy64
vagrant up
vagrant ssh
```

##

[Register a Linux server](https://epomatti.grafana.net/connections/add-new-connection/linux-node) with [Alloy](https://grafana.com/docs/alloy/latest/get-started/configuration-syntax/) to Grafana.

Configuration is derived from the following template files:

- https://storage.googleapis.com/cloud-onboarding/alloy/scripts/install-linux.sh
- https://storage.googleapis.com/cloud-onboarding/alloy/config/config.alloy

You can [configure Alloy](https://grafana.com/docs/alloy/latest/configure/) after it's installation:

```sh
/etc/alloy/config.alloy
```

Checkout the Linux [detailed configuration](https://grafana.com/docs/alloy/latest/configure/linux/) page for instructions.

Commands to manage Alloy:

```sh
sudo systemctl reload alloy
sudo systemctl restart alloy
```

For troubleshooting, enable the UI by passing [additional command-line flags](https://grafana.com/docs/alloy/latest/configure/linux/#pass-additional-command-line-flags).

Reference:

- [Introducing Grafana Alloy, A Distribution of the OTel Collector | GrafanaCON 2024 | Grafana](https://youtu.be/d9zLeFuIFIk)
- [Collect logs with Grafana Alloy](https://grafana.com/docs/grafana-cloud/send-data/logs/collect-logs-with-alloy/)
