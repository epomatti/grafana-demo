# Grafana Demo

Grafana Alloy deployment on a Linux host.

## Create the Linux Host

This setup will use Vagrant with VirtualBox to create a local test instance:

```sh
mkdir -p vagrant/grafana-demo
cd vagrant/grafana-demo

vagrant init ubuntu/jammy64
```

Use the [utils/Vagrantfile](./utils/Vagrantfile) content to optimize the box creation.

Then, create the box:

```sh
vagrant up
vagrant ssh
```

## Setup

> [!NOTE]
> Using the standard architecture. The Fleet Management feature is currently in [public preview](https://grafana.com/docs/grafana-cloud/whats-new/2024-11-21-fleet-management-in-public-preview/) and it was giving me trouble

Create and edit the variables file to configure Alloy. Use the [utils/template_alloy_vars.yml](utils/template_alloy_vars.yml) template:

```sh
sudo touch /etc/ansible/alloy_vars.yml
sudo chmod 600 /etc/ansible/alloy_vars.yml
sudo vim /etc/ansible/alloy_vars.yml
```

## Install Alloy

Use the Ansible playbooks to automate the Grafana configuration.

> [!TIP]
> In preference of fine-grained control, I'm implementing the [Install Grafana Alloy on Linux](https://grafana.com/docs/alloy/latest/set-up/install/linux/) steps, but an official Ansible role [is available](https://grafana.com/docs/alloy/latest/set-up/install/ansible/).

Clone the Git repository, and copy the [utils/ansible-pull.sh](utils/ansible-pull.sh) file for execution convenience.

Within the pull file, replace the `TOKEN` variable with a contents read-only Git token to be used for pulling configuration updates. You may instead prefer to use SSH and avoid dealing with tokens.

```sh
git clone https://oauth2:oauth-key-goes-here@github.com/epomatti/grafana-demo.git
```

Run the configuration playbook:

```sh
sudo bash utils/ansible-pull.sh
```

Verify that Alloy is installed and running:

```sh
sudo systemctl status alloy
```

Manual changes can also be reloaded instead of a restart:

```sh
sudo systemctl reload alloy
```

Configuration will be updated to the default path:

```sh
/etc/alloy/config.alloy
```

Service logs can be viewed within the journal:

```sh
sudo journalctl -u alloy
```

The configuration is a combination from the documentation and guided setup in the Grafana console, with reference files:

- https://storage.googleapis.com/cloud-onboarding/alloy/scripts/install-linux.sh
- https://storage.googleapis.com/cloud-onboarding/alloy/config/config.alloy

## Alerts

A high CPU query can be used from [here](https://medium.com/@18bhavyasharma/setting-up-alerts-for-cpu-usage-with-prometheus-and-grafana-40623e7a60b3).

```sh
100 * (1 - avg by(instance) (rate(node_cpu_seconds_total{mode="idle"}[5m]))) > 80
```

Check the number of CPUs:

```sh
lscpu
```

Run the stress to simulate the alert:

```sh
sudo stress-ng --cpu 2 -v --timeout 300s
```

## Extras

Additional connectors and settings can be implemented such as [prometheus.exporter.unix](https://grafana.com/docs/alloy/latest/reference/components/prometheus/prometheus.exporter.unix/).

For extended troubleshooting, enable the UI by passing [additional command-line flags](https://grafana.com/docs/alloy/latest/configure/linux/#pass-additional-command-line-flags).

Reference articles:

- [Introducing Grafana Alloy, A Distribution of the OTel Collector | GrafanaCON 2024 | Grafana](https://youtu.be/d9zLeFuIFIk)
- [Collect logs with Grafana Alloy](https://grafana.com/docs/grafana-cloud/send-data/logs/collect-logs-with-alloy/)
