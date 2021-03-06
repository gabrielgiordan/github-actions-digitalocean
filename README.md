![deploy](https://github.com/gabrielgiordan/github-actions-digitalocean/workflows/deploy/badge.svg)
# GitHub Actions DigitalOcean

GitHub actions workflows for DigitalOcean droplets, using DigitalOcean Spaces as the Terraform backend for `.tfstate` storage, domain name via DigitalOcean DNS and DigitalOcean Images for the snapshot image creation.

![Architecture overview](doc/images/architecture.png?raw=true "Architecture verview")

## Prerequisites

- [vagrant >= 2.2.8](https://www.vagrantup.com/docs/installation/)
- [ansible >= 2.9.7](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [packer >= 1.5.6](https://www.packer.io/intro/getting-started/)
- [terraform >= 0.12](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [doctl >= 1.43.0](https://www.digitalocean.com/docs/apis-clis/doctl/how-to/install/)

## Usage

### Vagrant

Vagrant is used to provision a VM locally using the VirtualBox to be used as the development environment. Start your VM with:

```bash
vagrant up
```

### Ansible

Ansible is used to configure the environment and its entry point playbook `main.yml` is provisioned with Vagrant or Packer workflow.

The default forwarded port on both environments is `8080`.

### Packer

Packer is used to create the OS image once for time savings on provisioning into different environments.

Packer at this project uses HCL2 syntax.

To run Packer at your local machine, create a file named `variables.pkvars.hcl` at the `packer` folder in order to store the Packer variables.

Then you can build your snapshot at packer folder:

```bash
packer build -var-file=variables.pkrvars.hcl .
```

### Terraform

Terraform is used to provision the infrastructure.

In order to use Terraform at a local machine, you must create a `terraform.tfvars` file within the `terraform` directory. Also you will need a file named `backend.tfvars` for the backend configuration with DigitalOcean Spaces as the provider.

Then you can init Terraform with:

```bash
terraform init --backend-config=backend.tfvars
```

## Frequently Asked Questions

How do I import an existing DigitalOcean droplet?
> Retrieve your DigitalOcean droplets then copy the droplet ID you wish to import:
>
> `doctl compute droplet list`
>
> Then import it into your Terraform state:
>
> `terraform import digitalocean_droplet.app_instance droplet_id`

How do I import an existing DigitalOcean domain?
> Retrieve your DigitalOcean domains and copy the one you wish to import:
>
> `doctl compute domain list`
>
> Then import it into your Terraform state:
>
> `terraform import digitalocean_domain.app_domain domain`

How do I support `hcl2` for Terraform >= 0.12?
> In order to support the Terraform version 0.12 at or greater with `hcl2` syntax support, install the [Terraform Language Server](https://github.com/mauve/vscode-terraform/issues/157#issuecomment-605020900)

Why using a separate file for backend variables on Terraform?
> Because Terraform does not allow variables inside a backend scope as seen on [issue #13022](https://github.com/hashicorp/terraform/issues/13022)

Why there is not a validate step at packer job?
> Validation with Packer using HCL2 syntax is currently unsupported from Hashicorp