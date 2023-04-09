# savgw-feature-server

A [packer](https://www.packer.io/) template to build an AMI for the savgw feature server.  The base linux distro is Centos.

## Installing 

To build an amd64 image:

```
$  packer build -color=false template.json
```

To build an arm64 image:

```
$  packer build -color=false \
--var="ami_base_image_arch=arm64" \
--var="instance_type=t4g.xlarge" \
template.json
```

### variables
There are many variables that can be specified on the `packer build` command line; however defaults (which are shown below) are appropriate for building an "all in one" savgw server, so you generally should not need to specify values.

```
"region": "us-east-1"
```
The region to create the AMI in

```
"ami_description": "savgw feature server"
```
AMI description.

```
"instance_type": "t2.medium"
```
EC2 Instance type to use when building the AMI.


```
"drachtio_version": "v0.8.4"
```
drachtio tag or branch to build

```
    "install_datadog": "no",
```
whether to install datadog (commercial) monitoring agent

```
    "install_telegraf": "yes",
```
whether to install telegraf (open source) monitoring agent

