# tfe-v4-ext-services-aws-airgap-asg-valid-cert
Install Prod version External Services ( S3 + DB ), ASG + LB with Valid Certificate - AWS install with airgap


# Requirements

This project is using Inspec. It is written in Ruby, so you will need to have some Ruby version compatible with KitchenCI installed on your workstation. For ways of doing this - please consult your operating system manual, or at least [official Ruby documentation](https://www.ruby-lang.org/en/documentation/installation/). As Inspec can utilize other Ruby packages, which are called [RubyGems](https://github.com/rubygems/rubygems), they are often managed by sets or "bundles". To simplify management of these sets we are going to use [Bundler](https://bundler.io/index.html#getting-started) 

To learn more about the mentioned above tools and technologies -  please check section [Technologies near the end of the README](#technologies)

## Packer


> Kitchen-Terraform supports versions of Terraform in the interval of
`>= 0.11.4, < 0.15.0`. But this project using code notation of TF 0.12+

## Inspec and dependencies

For this, to work you need InSpec CLI in your PATH

Installation with BRew om MacOS :

```
 brew install chef/chef/inspec
```

Taken from: https://docs.chef.io/inspec/install/


> Please note that for your convenience the [Gemfile](https://github.com/Galser/tf-test-output/blob/main/Gemfile) is provided at the root of this repository, which contains all the required packages to successfully install KitchenCI with Bundler. 

## Creating `basee` image

Satisfy requirements for Inspec and AWS credentials above and execute : 

```
packer build packer-templates
```

From the root of the cloned repo.


## How to test

Test naturally happens during the last phases of the build. Once you have all requirements satisfied (e.g. Inspec installed and credentials) you can proceed : 

### Failing Packer test example 

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

And here is a succesfull build :

```
==> amazon-ebs.ubuntu: Provisioning with Inspec...
==> amazon-ebs.ubuntu: Executing Inspec: inspec exec ./tests/basic_image --backend ssh --host 127.0.0.1 --user andrii --key-files /var/folders/nw/hlt5_kpd5lzb78xrft48ynqm0000gp/T/packer-provisioner-inspec.714625712.key --port 58283 --input-file /var/folders/nw/hlt5_kpd5lzb78xrft48ynqm0000gp/T/packer-provisioner-inspec.709707343.yml
    amazon-ebs.ubuntu: [2021-07-21T17:29:30+02:00] WARN: Input 'tfe_ver' does not have a value. Use --input-file or --input to provide a value for 'tfe_ver' or specify a  value with `input('tfe_ver', value: 'somevalue', ...)`.
    amazon-ebs.ubuntu:
    amazon-ebs.ubuntu: Profile: Ubuntu Ubuntu Linux Base AMI (packer-tests)
    amazon-ebs.ubuntu: Version: 0.0.1
    amazon-ebs.ubuntu: Target:  ssh://andrii@127.0.0.1:58283
    amazon-ebs.ubuntu:
    amazon-ebs.ubuntu:   ✔  operating_system: Check that OS is Ubuntu
    amazon-ebs.ubuntu:      ✔  Command: `lsb_release -a` stdout is expected to match /Ubuntu/
    amazon-ebs.ubuntu:
    amazon-ebs.ubuntu:   Service docker
    amazon-ebs.ubuntu:      ✔  is expected to be installed
    amazon-ebs.ubuntu:      ✔  is expected to be enabled
    amazon-ebs.ubuntu:      ✔  is expected to be running
    amazon-ebs.ubuntu:   System Package wget
    amazon-ebs.ubuntu:      ✔  is expected to be installed
    amazon-ebs.ubuntu:
    amazon-ebs.ubuntu: Profile Summary: 1 successful control, 0 control failures, 0 controls skipped
    amazon-ebs.ubuntu: Test Summary: 5 successful, 0 failures, 0 skipped
==> amazon-ebs.ubuntu: Stopping the source instance...
    amazon-ebs.ubuntu: Stopping instance
==> amazon-ebs.ubuntu: Waiting for the instance to stop... 
```

## Check the requirements for TFE

Check the requirement for TFE here: https://www.terraform.io/docs/enterprise/before-installing/index.html

## Prepare S3 bucket

According to https://www.terraform.io/docs/enterprise/before-installing/reference-architecture/aws.html#object-storage-s3-  create a bucket at a suitable location/region of your choice. The name used in this demo is : 
`ag-test-16`

## Prepare Security group for future EC2 instance

Prepare a security group that will allow ingress of the ports 22 (SSH), 443 (HTTPS), and 8800 (Replicated console), with fully open outgress. 

## Prepare PostgresDB

- Create a PostgresDB according to the [requirements](https://www.terraform.io/docs/enterprise/before-installing/reference-architecture/aws.html#postgresql-database-rds-multi-az-) in a suitable location/region of your choice. The current choice (as of August 2021) is to use PostgreSQL 12. 
- Include the earlier created security group in the allowed access list.

## Prepare IAM role and policy for authorization of EC2 instance to S3

- Create S3 bucket policy, minimal JSON utilized during this demo is presented below : 

```JSON
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:DeleteObject",
                "s3:GetBucketLocation"
            ],
            "Resource": [
                "arn:aws:s3:::ag-test-16",
                "arn:aws:s3:::*/*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "*"
        }
    ]
}
```

- Create a role and attach the newly created policy. Demo using policy `andrii-tfe-test-for-ag`

## Allocate certificate with the tool and providers of your choice

- I am using Let'sEncrypt with CloudFlare and assigning a domain: `tfe-andrii-ag-test-01.guselietov.com`. Later the actual hostname is going to be CNAME to Amazon's ALB DNS
- Don't forget to upload the certificate to Amazon ACM if you had used an external CA

## Create AMI with Replicated and TFE from packer image

- Start EC2 instance of the recommended size ( m4.xlarge for the start)
- Transfer Airgap package to the instance
- Proceed with TFE installation in External Services mode according to the manual: https://www.terraform.io/docs/enterprise/install/installer.html#run-the-installer-airgapped. Utilize the before-created IAM role and select `IAM role authorization` for the S3 Object Storage setting. **DON'T  PUT ANY DATA IN THE AWS KEY/SECRET KEY SECTIONS** - as Replicated going to try them, even if you have role configure and your tests will fail
- Use the same hostname as at the previous step - the one that is specified in the certificate.
- After TFE installed, running successfully and you can access its UI, do a minimal configuration and proceed with the next phase


## Prepare applications and startup script

We are going to prepare this running EC2 instance to be converted into AMI, which can be used as an image for Auto Scaling Group. TFE by itself is a black box with the state that is in S3 and PostgreSQL, so it will not present us with any problem. Replicated though, is tied to the local IP address, which should be changed every time in 2 config files when the instance rebooted. It's reflected in this KB: https://help.replicated.com/community/t/how-to-handle-ip-change/184

Let's proceed
- Using `scp` or any other tools that you prefer a transfer to the instance 2 following files from `files` folder if the cloned repo: 
    - `replicated.config.tmpl` 
    - `replicated-operator.config.tmpl`
- Login to the EC2 instance via SSH or any other means os you are going to have root access
- Copy the earlier transfer files to the `/root` folder.
- Disable Replicated daemons that are IP-tied by running : 

```
systemctl disable replicated replicated-operator replicated-ui
```

- Create [/etc/rc.local]() script with the following content : 

```BASH
#!/usr/bin/env bash

# Script to ensure that Replicated running on instance has correct IP,
# it is going to grab the instance private IP and put it in 2 files :
#
#  /etc/default/replicated
#  /etc/default/replicated-operator

INSTANCE_PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

eval "echo \"$(cat /root/replicated.config.tmpl)\"" > /etc/default/replicated
eval "echo \"$(cat /root/replicated-operator.config.tmpl)\"" > /etc/default/replicated-operator

# Enable Replicated
systemctl enable replicated replicated-operator replicated-ui

# Note - we don't need to restart replicated-ui, even if it is already running
systemctl start replicated replicated-operator replicated-ui
echo Waiting for replicated to get online after a restart

# Wait for Replicated to load
flag=1
while [ $flag -ne 0 ]
do
  echo .
  sleep 5
  systemctl is-active --quiet service replicated
  flag=${?}
  echo Flag = $flag
done
```

- Make it executable by running : 

```
chmod +x /etc/rc.local
```
- Log-out
- In the EC2 Console, select our, still running EC2 instance, from the drop-down menu **"Actions"** choose **"Image and templates"** and then **Create image**
- This can take a while, wait for the process to finish. Normally that's 10-15 minutes
- Shutdown the instance

## Create launch configuration

- Choose the AMI created in previous step ( in screenshots that's `ami-0000aa2b7f547a464` )
- Choose instance type - at least `m4.xlarge`
- In the `Additional configuration - optional` - choose the earlier created IAM role
- Under `Security groups` - select the proper security group
- And under `Key pair (login)` - choose your key  
- Save it
 
## Create Auto Scaling group

- Choose early created launch configuration, proper VPC, and subnets 
- Select on the next step - "Attach to a new load-balancer"
    + select name
    + Application load balancer
    + Internet-facing
    + proper VPC and subntes
    + Listners and rounting  - HTTPS !!! Enter port 443 As by default it will be HTTP and por 80, and you will need to adjust it earleir in the Load balancing console
    + Choose "new target group", enter name 
- Group size:  put "1" everywhere, no scaling policies
- Go to the last page and confirm creation with "Create Auto Scaling Group"

## Attach certificate to the ALB

- Go to the EC2 console, Load Balancers
- Select earlier create balancer
    + Listeners - add HTTPS listener and select your certificate 

## Tune target group

The default target group created as part of ALB creation will have incorrect health checks, for our needs. Locate it in the EC2 Console --> Target Groups and edit so the target check going to be : 

-  Use sub URL : `/_health_check`
-  Timeout: `10 sec`
-  Interval: `30 sec`
-  Healthy threshold `3`
-  Unhealthy threshold `3`


Basically - that's it. Now wait for ASG to start the instance, and for ALB health checks to become green, and you should have your TFE up and running.

You can experiment and try killing instance, and observe new coming back to replace the dead/removed one. 

The set of screenshots illustrating steps above is avaible in [screenshots](screenshots) folde in the repository.

# Cleanup

Don't forget to delete all the resources after you finished with the tests.


# Technologies


-  **To download the content of this repository** you will need **git command-line tools**(recommended) or **Git UI Client**. To install official command-line Git tools please [find here instructions](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) for various operating systems. 

-  **For managing infrastructure** we using Terraform - open-source infrastructure as a code software tool created by HashiCorp. It enables users to define and provision a data center infrastructure using a high-level configuration language known as Hashicorp Configuration Language, or optionally JSON. More you encouraged to [learn here](https://www.terraform.io). 

- **KitchenCI** - provides a test harness to execute infrastructure code on one or more platforms in isolation. For more details please check the product site : [KitchenCI](https://kitchen.ci/)

- **RubyGems** is a package manager for the Ruby programming language that provides a standard format for distributing Ruby programs and libraries (in a self-contained format called a "gem"), a tool designed to easily manage the installation of gems, and a server for distributing them. More here: https://rubygems.org/

- **Bundler** provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed. Bundler is an exit from dependency hell and ensures that the gems you need are present in development, staging, and production. Starting work on a project is as simple as bundle install. In details here: https://bundler.io/index.html#getting-started


# ReplicatedUI notes

IP change: https://help.replicated.com/community/t/how-to-handle-ip-change/184

You can update the PRIVATE_ADDRESS, DAEMON_HOST, and PUBLIC_ADDRESS parameters in /etc/default/replicated and /etc/default/replicated-operator. Then you can run `systemctl restart replicated replicated-operator` to pick up the changes.

- Check the scripts in files

- For AMI we are forced to leave data in ReplicatedUI DB ( e.g. issue `replicatedctl app start` ) but disable the
systemctl stat of Replicated services to speed-up server boot and readiness (e.g. avoid restart at the server boot)
 `systemctl disable replicated replicated-operator replicated-ui`

# Templates 

All scripts/templates are in the folder [files](files)

# TODO

- [X] define minimum Packer template in HCL
- [X] test it
- [x] move Packer template(s) in sub-folder
- [x] create first tests for image - packages like `wget`, `docker` and OS
- [x] fail them 
- [x] create base image Packer template from base AMI defined earlier - add some packages provision - `wget`, `docker`
- [x] run tests and fix typos , repeat steps  test - add provision- fail - until it's not failing anymore
- [x] add test for the rest of required packages
- [x] add provisions for the rest required packages
- [x] satisfy them
- [x] add tests for the Docker service in AMI
- [x] fail it in EC2 provisioned from current AMI
- [x] fix AMI, satisfy AMI
- [x] define where we want to keep AirGap bundle
- [x] put AirGap in place
- [x] add TFE install
- [x] rinse and repeat
- [x] define my subdomain
- [x] create certificate
- [x] create LB - with early defined certificate  
- [x] create DB & S3 Bucker
- [x] create ASG - using  AMI defined earlier
- [x] test TFE - run 1 instance
- [x] kill the instance
- [x] confirm that it is redeployed and working
