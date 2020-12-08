# Coupling to the Dependency Graph

Terraform calculates a dependency graph from configuration files it is passed.
When the output of one resource is used as the input of another, Terraform
recognizes that the former resource must be created first. Terraform also
recognizes that a change requires changing the target as well as all of its
dependencies. What does this mean for Fedora CoreOS? If we use the output of
resources as the input to our FCCT specification then our operating systems
will partipate in this dependency graph.

This tight coupling between the state of the infrastructure and the state of
the operating system saves us the pain of feeding the output of Terraform into
a configuration management system like Chef or Ansible.

As an example, lets set up a simple load balancer in front of a set of web
servers. The configuration for the load balancer can be found in `lb.yaml` and
the web servers can be found in `web.yaml`. Once again, we find the Terraform
resources in `main.tf`. Notice that the IP addresses of the web servers are fed
into the load balancer config file.

To run the example, once again we simply run

```bash
# Pull dependencies
terraform init

# Deploy!
terraform apply
```

Once complete you'll see the load balaner IP address printed as output. If you
load the address in your browser you'll see a simple message from each server:

```bash
$ export LB={{load balancer IP here}}
$ curl $LB
<html>
  <h1>Hello from Server 0</h1>
</html>
$ curl $LB
<html>
  <h1>Hello from Server 1</h1>
</html>
$ curl $LB
<html>
  <h1>Hello from Server 2</h1>
</html>
``` 

The number of web servers is a configured as a variable 

```terraform
locals {
    webserver = 3
}
```

Try changing this variable and applying the update. Note that on addition of
new webservers, the load balancer is automatically reprovisioned. This is
perfect because the load balancer needs to know about the ip addresses of the
new servers.
