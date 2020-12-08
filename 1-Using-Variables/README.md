# Using Variables

In our first example, we used a static password for our user. In this example,
we'll pass an SSH key as a Terraform [variable] instead.

[variables]: https://www.terraform.io/docs/configuration/variables.html

`config.yaml` remains mostly the same with the exception of `${ssh_key}` being
in the place an SSH key is supposed to be. This value will be replaced using
Terraform's [`templatefile`][templatefile] function.

[templatefile]:
https://www.terraform.io/docs/configuration/functions/templatefile.html

To deploy the example run,

```bash
# Download dependencies
terraform init

# Deploy!
terraform apply -var="ssh_key={{ place your SSH public key here }}"
```

Once the deployment is complete, the public IP address of the node will be
printed.  You can now SSH to the node as the `user` user and your SSH key.
