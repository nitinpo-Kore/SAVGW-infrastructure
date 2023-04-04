# savgw-feature-server

A [packer](https://www.packer.io/) template to build an AMI for the SAVGW feature server.  The base linux distro is Debian 10 (buster).

## Installing 

```
$  packer build -color=false template.json
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

