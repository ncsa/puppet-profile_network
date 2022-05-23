# profile_network

![pdk-validate](https://github.com/ncsa/puppet-profile_network/workflows/pdk-validate/badge.svg)
![yamllint](https://github.com/ncsa/puppet-profile_network/workflows/yamllint/badge.svg)

NCSA configure networking

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with profile_network](#setup)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Dependencies](#dependencies)
1. [Reference](#reference)

## Description

NCSA configure networking

## Setup
Include profile_network in a puppet profile file:
```
include ::profile_network
```

## Usage

The goal is that no paramters are required to be set. The default paramters should work for most NCSA deployments out of the box.

## Dependencies

* https://github.com/ncsa/puppet-telegraf
* https://github.com/ncsa/puppet-profile_monitoring

## Reference

See: [REFERENCE.md](REFERENCE.md)
