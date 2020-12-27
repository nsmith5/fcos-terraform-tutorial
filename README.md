# Fedora CoreOS Terraform tutorial

_A tutorial about using Fedora CoreOS and Terraform together_

This helps you discover how to use [Fedora CoreOS][fcos] and
[Terraform][terraform] together. To run through the tutorial you'll need an AWS
account and credentials set up via `aws configure`. There are three demos:

[fcos]: https://getfedora.org/coreos?stream=stable
[terraform]: https://www.terraform.io/

- [Hello World](./0-Hello-World) shows the basics of Terraform and how you can
  create Fedora CoreOS servers using the ct provider from Poseidon labs
- [Using Variables](./1-Using-Variables) Shows how you can pass variables into
  your FCCT specification using `templatefile`.
- [Leveraging the Dependency Graph](./2-Dependencies) Demonstrates how you can
  couple systems together using a load balancer example.

You can also read along in the [article published on Fedora Magazine][article]

[article]: https://fedoramagazine.org/deploy-fedora-coreos-with-terraform/
