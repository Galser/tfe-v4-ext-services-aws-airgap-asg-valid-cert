# tfe-v4-ext-services-aws-airgap-asg-valid-cert
Install Prod version External Services ( S3 + DB ), ASG + LB with Valid Certificate - AWS install with airgap


# Steps

- Do not forget AWS env data! 

# Packer base

- Template
- `packer init`
- `packer build <folder>`

# Requirements

This project is using [KitchenCI](https://kitchen.ci/). It is written in Ruby, so you will need to have some Ruby version compatible with KitchenCI installed on your workstation. For ways of doing this - please consult your operating system manual, or at least [official Ruby documentation](https://www.ruby-lang.org/en/documentation/installation/). As KitchenCI can utilize other Ruby packages, that are called [RubyGems](https://github.com/rubygems/rubygems), they are often managed by sets or "bundles". To simplify management of these sets we are going to use [Bundler](https://bundler.io/index.html#getting-started) 

To learn more about the mentioned above tools and technologies -  please check section [Technologies near the end of the README](#technologies)

## Packer


> Kitchen-Terraform supports versions of Terraform in the interval of
`>= 0.11.4, < 0.15.0`. But this project using code notation of TF 0.12+

## Inspec and dependencies

For this to work you need InSpec CLI in your PATH

Installation with BRew om MacOS :

```
 brew install chef/chef/inspec
```

Taken from : https://docs.chef.io/inspec/install/


> Please note that for your convenience the [Gemfile](https://github.com/Galser/tf-test-output/blob/main/Gemfile) is provided at the root of this repository, which contains all the required packages to successfully install KitchenCI with Bundler. 

## How to test

Test naturally happens during last phases of build. Once you have all requirements satisfied (e.g. Inspec installed and credentials) you can proceed : 

### Failing test example 

```
 packer build packer-templates
amazon-ebs.ubuntu: output will be in this color.

==> amazon-ebs.ubuntu: Prevalidating any provided VPC information
==> amazon-ebs.ubuntu: Prevalidating AMI Name: packer-ubuntu-linux-basic
    amazon-ebs.ubuntu: Found Image ID: ami-032d3b1d0246c218e
==> amazon-ebs.ubuntu: Creating temporary keypair: packer_60f82b86-634b-3e87-7886-88ae4efb11f7
==> amazon-ebs.ubuntu: Creating temporary security group for this instance: packer_60f82b88-4728-2634-c946-920e1bd1ad13
==> amazon-ebs.ubuntu: Authorizing access to port 22 from [0.0.0.0/0] in the temporary security groups...
==> amazon-ebs.ubuntu: Launching a source AWS instance...
==> amazon-ebs.ubuntu: Adding tags to source instance
    amazon-ebs.ubuntu: Adding tag: "Name": "Packer Builder"
    amazon-ebs.ubuntu: Instance ID: i-04f701a2c1a999d85
==> amazon-ebs.ubuntu: Waiting for instance (i-04f701a2c1a999d85) to become ready...
==> amazon-ebs.ubuntu: Using SSH communicator to connect: 18.197.144.29
==> amazon-ebs.ubuntu: Waiting for SSH to become available...
==> amazon-ebs.ubuntu: Connected to SSH!
==> amazon-ebs.ubuntu: Provisioning with Inspec...
==> amazon-ebs.ubuntu: Executing Inspec: inspec exec ./tests/basic_image --backend ssh --host 127.0.0.1 --user andrii --key-files /var/folders/nw/hlt5_kpd5lzb78xrft48ynqm0000gp/T/packer-provisioner-inspec.896514280.key --port 55536 --input-file /var/folders/nw/hlt5_kpd5lzb78xrft48ynqm0000gp/T/packer-provisioner-inspec.073195815.yml
    amazon-ebs.ubuntu: [2021-07-21T16:14:27+02:00] WARN: Input 'tfe_ver' does not have a value. Use --input-file or --input to provide a value for 'tfe_ver' or specify a  value with `input('tfe_ver', value: 'somevalue', ...)`.
    amazon-ebs.ubuntu:
    amazon-ebs.ubuntu: Profile: Ubuntu Ubuntu Linux Base AMI (packer-tests)
    amazon-ebs.ubuntu: Version: 0.0.1
    amazon-ebs.ubuntu: Target:  ssh://andrii@127.0.0.1:55536
    amazon-ebs.ubuntu:
    amazon-ebs.ubuntu:   ✔  operating_system: Check that OS is Ubuntu
    amazon-ebs.ubuntu:      ✔  Command: `lsb_release -a` stdout is expected to match /Ubuntu/
    amazon-ebs.ubuntu:
    amazon-ebs.ubuntu:   Service docker
    amazon-ebs.ubuntu:      ×  is expected to be installed
    amazon-ebs.ubuntu:      expected that `Service docker` is installed
    amazon-ebs.ubuntu:      ×  is expected to be enabled
    amazon-ebs.ubuntu:      expected that `Service docker` is enabled
    amazon-ebs.ubuntu:      ×  is expected to be running
    amazon-ebs.ubuntu:      expected that `Service docker` is running
    amazon-ebs.ubuntu:
    amazon-ebs.ubuntu: Profile Summary: 1 successful control, 0 control failures, 0 controls skipped
    amazon-ebs.ubuntu: Test Summary: 1 successful, 3 failures, 0 skipped
==> amazon-ebs.ubuntu: Provisioning step had errors: Running the cleanup provisioner, if present...
==> amazon-ebs.ubuntu: Terminating the source AWS instance...
==> amazon-ebs.ubuntu: Cleaning up any extra volumes...
==> amazon-ebs.ubuntu: No volumes to clean up, skipping
==> amazon-ebs.ubuntu: Deleting temporary security group...
==> amazon-ebs.ubuntu: Deleting temporary keypair...
Build 'amazon-ebs.ubuntu' errored after 2 minutes 17 seconds: Error executing Inspec: Inspec exited with unexpected exit status: 100. Expected exit codes are: [0 101]

==> Wait completed after 2 minutes 17 seconds

==> Some builds didn't complete successfully and had errors:
--> amazon-ebs.ubuntu: Error executing Inspec: Inspec exited with unexpected exit status: 100. Expected exit codes are: [0 101]

==> Builds finished but no artifacts were created.
```

    And in case of a successful run the last 2 lines of output should be  like this : 

This ends up the instructions, thank you. 


# Technologies


-  **To download the content of this repository** you will need **git command-line tools**(recommended) or **Git UI Client**. To install official command-line Git tools please [find here instructions](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) for various operating systems. 

-  **For managing infrastructure** we using Terraform - open-source infrastructure as a code software tool created by HashiCorp. It enables users to define and provision a data center infrastructure using a high-level configuration language known as Hashicorp Configuration Language, or optionally JSON. More you encouraged to [learn here](https://www.terraform.io). 

- **KitchenCI** - provides a test harness to execute infrastructure code on one or more platforms in isolation. For more details please check the product site : [KitchenCI](https://kitchen.ci/)

- **RubyGems** is a package manager for the Ruby programming language that provides a standard format for distributing Ruby programs and libraries (in a self-contained format called a "gem"), a tool designed to easily manage the installation of gems, and a server for distributing them. More here: https://rubygems.org/

- **Bundler** provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed. Bundler is an exit from dependency hell, and ensures that the gems you need are present in development, staging, and production. Starting work on a project is as simple as bundle install. In details here: https://bundler.io/index.html#getting-started


# Templates



# TODO

- [X] define minimum Packer template in HCL
- [X] test it
- [x] move Packer template(s) in sub-folder
- [x] create first tests for image - packages like `wget`, `docker` and OS
- [ ] fail them 
- [ ] create base image Packer template from base AMI defined earlier - add some packages provision - `wget`, `docker`
- [ ] run tests and fix typos , repeat steps  test - add provisio- fail - until it's not failing anymore
- [ ] add test for the rest required packages
- [ ] add provisions for the rest required packages
- [ ] satisfy them
- [ ] add tests for the Docker service in AMI
- [ ] fail it in EC2 provisioned from current AMI
- [ ] fix AMI, satisfy AMI
- [ ] define where we want to keep AirGap bundle
- [ ] put AirGap in place
- [ ] add the AirGap binaries tests
- [ ] fail them & then satisfy them
- [ ] rinse and repeat
- [ ] add TFE install
- [ ] define my subdomain
- [ ] create certificate
- [ ] create ASG - using  AMI defined earlier
- [ ] create LB - with early defined certificate  
- [ ] create DB & S3 Bucker
- [ ] test TFE - run 1 instance
- [ ] kill instance
- [ ] confirm that it is redeployed and working