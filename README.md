# tfe-v4-ext-services-aws-airgap-asg-valid-cert
Install Prod version External Services ( S3 + DB ), ASG + LB with Valid Certificate - AWS install with airgap


# Steps

# TODO

- [X] define minimum Packer template in HCL
- [X] test it
- [ ] create first tests for image - packages like `wget`, `docker`
- [ ] add test for packes
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