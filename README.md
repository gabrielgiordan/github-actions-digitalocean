![terraform](https://github.com/gabrielgiordan/github-actions-digitalocean/workflows/terraform/badge.svg)
# GitHub Actions DigitalOcean

GitHub actions workflows for DigitalOcean droplets, using DigitalOcean Spaces as the Terraform backend for `.tfstate` storage.

## Prerequisites

- [terraform >= 0.12](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [doctl](https://www.digitalocean.com/docs/apis-clis/doctl/how-to/install/)

## Usage

In order to use Terraform at a local machine, you must create a `./terraform/terraform.tfvars` file with the following Terraform variables:

```hcl
digitalocean_instance_name       = "app"                // The DigitalOcean droplet name
digitalocean_api_token           = "15d37a5"            // The DigitalOcean API token
digitalocean_public_ssh_key_name = "app_ssh_public_key" // The DigitalOcean public SSH key name
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

How do I support `hcl2` for Terraform >= 0.12?
> In order to support the Terraform version 0.12 at or greater with `hcl2` syntax support, install the [Terraform Language Server](https://github.com/mauve/vscode-terraform/issues/157#issuecomment-605020900)

Why using a separate file for backend variables on Terraform?
> Because Terraform does not allow variables inside a backend scope as seen on [issue #13022](https://github.com/hashicorp/terraform/issues/13022)