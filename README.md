![terraform](https://github.com/gabrielgiordan/github-actions-digitalocean/workflows/terraform/badge.svg)
# GitHub Actions DigitalOcean

GitHub actions workflows for DigitalOcean droplets, using DigitalOcean Spaces as the Terraform backend for `.tfstate` storage and domain name via DigitalOcean DNS.

## Prerequisites

- [terraform >= 0.12](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [packer >= 1.5.6](https://www.packer.io/intro/getting-started/)
- [doctl](https://www.digitalocean.com/docs/apis-clis/doctl/how-to/install/)

## Usage

### Packer

Packer at this project uses HCL2 syntax.

To run Packer at your local machine, create a file named `variables.pkvars.hcl` at the `packer` folder in order to store your variables.

Then you can build your snapshot at packer folder:
`packer build -var-file=variables.pkrvars.hcl .`

### Terraform

In order to use Terraform at a local machine, you must create a `./terraform/terraform.tfvars` file with the following Terraform variables:

```hcl
digitalocean_instance_name       = "app"                // The DigitalOcean droplet name
digitalocean_api_token           = "15d37a5"            // The DigitalOcean API token
digitalocean_public_ssh_key_name = "app_ssh_public_key" // The DigitalOcean public SSH key name
digitalocean_domain_name         = "app.com"            // The DigitalOcean droplet domain
```

Also the `./terraform/backend.tfvars` for the backend configuration with DigitalOcean Spaces as the provider:

```hcl
key        = "app/terraform.tfsate" // The Terraform state key for .tfstate
bucket     = "nx02l"                // The DigitalOcean space subdomain name
access_key = "23a71u8"              // The DigitalOcean Spaces access key
secret_key = "85p32a1"              // The DigitalOcean Spaces secret key
```

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