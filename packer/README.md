# packer scripts

[packer](https://www.packer.io/) is a tool for building machine images.  This folder contains packer templates for building AWS AMIs for running jambonz on AWS.

## Building a single "all-in-one" AMI

The [savgw-mini](./savgw-mini) packer template builds an AWS machine instance that contains all of the jambonz components on a single server.  A savgw-mini system is typically used for development and testing purposes, or to run a smaller production system.

Once you have created the AMIs you can then deploy the cluster using the [savgw-mini.yaml](../cloudformation/savgw-mini.yaml) cloudformation script. Be sure to edit that CF script to reference your AMI ids and region in the Mappings section of the yaml document.

## Building a scalable jambonz cluster

To build a horizontally-scalable jambonz cluster you will need to build 5 distinct AWS AMIs using these packer templates:

- [savgw-feature-server](./savgw-feature-server)
- [savgw-monitoring](./savgw-monitoring)
- [savgw-sbc-sip](./savgw-sbc-sip)
- [savgw-sbc-rtp](./savgw-sbc-rtp)
- [savgw-web-server](./savgw-web-server)

Once you have created the AMIs you can then deploy the cluster using the [savgw-scalable-production.yaml](../cloudformation/savgw-scalable-production.yaml) cloudformation script. Be sure to edit that CF script to reference your AMI ids and region in the Mappings section of the yaml document.