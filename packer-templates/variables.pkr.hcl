//  variables.pkr.hcl

variable "ssh_username" {
  default = "ubuntu" // may be "ec2user" for Amazon Linux
}

variable "canonical_ami_owner_id" {
  default = "099720109477"
}

variable "instance_type" {
  default = "m5.xlarge"
}

variable "region" {
  default = "eu-central-1"
}

/* variable "canonical_id" {
  type =  string
  default = "mypassword"
  // Sensitive vars are hidden from output as of Packer v1.6.5
  sensitive = true
}

*/
