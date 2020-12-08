# Hello Fedora CoreOS

This first example shows a basic example of using Fedora CoreOS and Terraform
together. The FCCT configuration can be found in `config.yaml`. The file is
transpiled and added as user data to a single instance created in the `main.tf`
Terraform file. To run the example simple run

```bash
# Download dependencies
terraform init

# Deploy!
terraform apply
```

Upon completion the public IP address of the instance will be printed. You can
log in via SSH using the user `user` and password `weakpassword`.

You can delete your instance by running `terraform destroy`.
