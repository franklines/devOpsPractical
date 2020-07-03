# Packer & Ansible for custom AMI

### Install Packer & Ansible on workstation (or use docker image)
```bash
# Download
wget https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip

# Unzip  and install   
unzip packer_1.6.0_linux_amd64.zip
sudo cp packer /usr/local/bin

# Since we are using Ansible as our provisioner, we need ansible.
# Below are steps for installing on debian distro (ubuntu, elementary, etc.)
sudo apt-add-repository ppa:ansible/ansible; sudo apt-get update; sudo apt-get install ansible -y
``` 

### Using Packer to validate
```bash
# Validate our build template
packer validate eks-worker.json

# Preview
packer inspect eks-worker.json


09:05:19 frank@frank-t420 packer ±|master ✗|→ packer inspect eks-worker.json 
Optional variables and their defaults:

  ami_id   = ami-0d960646974cf9e5b
  app_name = eksWorkerCustom-1.16

Builders:

  amazon-ebs

Provisioners:

  ansible

# NOTE: ami-0d960646974cf9e5b is the AWS provided EKS 1.16 image in us-east-1 region.


# Build new custom image
packer build eks-worker.json


09:07:14 frank@frank-t420 packer ±|master ✗|→ packer build eks-worker.json 
amazon-ebs: output will be in this color.

==> amazon-ebs: Prevalidating any provided VPC information
==> amazon-ebs: Prevalidating AMI Name: eksWorkerCustom-1.16
    amazon-ebs: Found Image ID: ami-0d960646974cf9e5b
==> amazon-ebs: Creating temporary keypair: packer_5efe92d5-d127-2683-8659-b75366f77a37
==> amazon-ebs: Creating temporary security group for this instance: packer_5efe92d7-be61-73f4-63c7-4c6bae9ccc27
==> amazon-ebs: Authorizing access to port 22 from [0.0.0.0/0] in the temporary security groups...
==> amazon-ebs: Launching a source AWS instance...
==> amazon-ebs: Adding tags to source instance
    amazon-ebs: Adding tag: "Name": "Packer Builder"
    amazon-ebs: Instance ID: i-066f8dd636e0f858e
==> amazon-ebs: Waiting for instance (i-066f8dd636e0f858e) to become ready...
==> amazon-ebs: Using ssh communicator to connect: 54.237.227.39
==> amazon-ebs: Waiting for SSH to become available...
==> amazon-ebs: Connected to SSH!
==> amazon-ebs: Provisioning with Ansible...
    amazon-ebs: Setting up proxy adapter for Ansible....
==> amazon-ebs: Executing Ansible: ansible-playbook -e packer_build_name=amazon-ebs -e packer_builder_type=amazon-ebs -e packer_http_addr=ERR_HTTP_ADDR_NOT_IMPLEMENTED_BY_BUILDER --ssh-extra-args '-o IdentitiesOnly=yes' -e ansible_ssh_private_key_file=/tmp/ansible-key376218436 -i /tmp/packer-provisioner-ansible594461139 /home/frank/Projects/Practical/devOpsPractical/packer/playbook.yaml
    amazon-ebs:
    amazon-ebs: PLAY [Install NTP Package] *****************************************************
    amazon-ebs:
    amazon-ebs: TASK [Gathering Facts] *********************************************************
    amazon-ebs: [WARNING]: Platform linux on host default is using the discovered Python
    amazon-ebs: ok: [default]
    amazon-ebs: interpreter at /usr/bin/python, but future installation of another Python
    amazon-ebs: interpreter could change this. See https://docs.ansible.com/ansible/2.9/referen
    amazon-ebs: ce_appendices/interpreter_discovery.html for more information.
    amazon-ebs:
    amazon-ebs: TASK [Install NTPD] ************************************************************
    amazon-ebs: changed: [default]
    amazon-ebs:
    amazon-ebs: PLAY RECAP *********************************************************************
    amazon-ebs: default                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
    amazon-ebs:
==> amazon-ebs: Stopping the source instance...
    amazon-ebs: Stopping instance
==> amazon-ebs: Waiting for the instance to stop...
==> amazon-ebs: Creating AMI eksWorkerCustom-1.16 from instance i-066f8dd636e0f858e
    amazon-ebs: AMI: ami-0c8e2a04db4cacb78
==> amazon-ebs: Waiting for AMI to become ready...
==> amazon-ebs: Adding tags to AMI (ami-0c8e2a04db4cacb78)...
==> amazon-ebs: Tagging snapshot: snap-0f516618aff48dace
==> amazon-ebs: Creating AMI tags
    amazon-ebs: Adding tag: "Name": "eksWorkerCustom-1.16"
    amazon-ebs: Adding tag: "Env": "Dev"
==> amazon-ebs: Creating snapshot tags
==> amazon-ebs: Terminating the source AWS instance...
==> amazon-ebs: Cleaning up any extra volumes...
==> amazon-ebs: No volumes to clean up, skipping
==> amazon-ebs: Deleting temporary security group...
==> amazon-ebs: Deleting temporary keypair...
Build 'amazon-ebs' finished.

==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:
us-east-1: ami-0c8e2a04db4cacb78

```

## Verify NTP package is installed
```bash
09:13:58 frank@frank-t420 packer ±|master ✗|→ ssh -i ~/.ssh/eks.pem ec2-user@35.153.19.191
Last login: Thu Jun 18 01:20:30 2020 from 205.251.233.50

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
4 package(s) needed for security, out of 10 available
Run "sudo yum update" to apply all updates.
[ec2-user@ip-172-31-49-112 ~]$ rpm -qa | grep -i ntp
ntpdate-4.2.6p5-29.amzn2.0.1.x86_64
ntp-4.2.6p5-29.amzn2.0.1.x86_64

```