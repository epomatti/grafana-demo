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

## Configuration

> [!NOTE]
> Using the standard architecture. The Fleet Management feature is currently in [public preview](https://grafana.com/docs/grafana-cloud/whats-new/2024-11-21-fleet-management-in-public-preview/) and it was giving me trouble

Create the variables file to configure Alloy:

```sh
sudo touch /etc/ansible/alloy_vars.yml
sudo chmod 600 /etc/ansible/alloy_vars.yml
```

Edit the variables file using the [utils/template_alloy_vars.yml](utils/template_alloy_vars.yml) template.

Create and edit the API Key file that will be used to authenticate to Grafana Cloud:

```sh
sudo touch /etc/alloy/gcloud_rw_api_key
sudo chmod 600 /etc/alloy/gcloud_rw_api_key
```


https://storage.googleapis.com/cloud-onboarding/alloy/scripts/install-linux-binary.sh

- https://storage.googleapis.com/cloud-onboarding/alloy/scripts/install-linux.sh
- https://storage.googleapis.com/cloud-onboarding/alloy/config/config.alloy

```sh
sudo journalctl -u alloy
```

## Install Alloy

Use the Ansible playbooks to automate the Grafana configuration.

> [!TIP]
> In preference of fine-grained control, I'm implementing the [Install Grafana Alloy on Linux](https://grafana.com/docs/alloy/latest/set-up/install/linux/) steps, but an official Ansible role [is available](https://grafana.com/docs/alloy/latest/set-up/install/ansible/).

Clone the Git repository, and copy the [utils/ansible-pull.sh](utils/ansible-pull.sh) file for execution convenience.

Within the pull file, replace the `TOKEN` variable with a contents read-only Git token to be used for pulling configuration updates. You may instead prefer to use SSH and avoid dealing with tokens.

Run the configuration playbook:

```sh
sudo ./pull.sh
```

Verify that Alloy is installed and running:

```sh
sudo systemctl status alloy
```

## Collect Data

https://grafana.com/docs/alloy/latest/reference/components/prometheus/prometheus.exporter.unix/

## Configuring Alloy

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
