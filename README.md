# Contrail_Kubernetes_AWS_Ansible-Boto
Contrail CNI-Kubernetes with Containarized Control Plane on AWS

## Provisioning Kubernetes with Flannel using Ansible & Python-Boto on Amazon Web Services

Ansible’s EC2 module uses python-boto library to call AWS API, and boto needs AWS credentials in order to function.

The solution is organized in 3 parts:

*	A generic Ansible role that uses ec2 module to provision
*	Yaml files with variables that will be used as parameters for each type of EC2 host
* Playbook that combines the variables file with the role

## Prerequisites

*	ansible 
*	awscli
*	python-pip
*	boto
*	AWS account which can allow users to use Large and Medium EC2 instances (Usually not available in free-tier)
*	AWS account access and secret keys

## Procedure

1.	A CloudFormation template is used to create a build-host which has all the packages required as specified above (ansible, awcli, python-pip and boto), this includes the repo with ansible-framework required to provision the cluster.

    * Creates VPC, Subnet, EC2 Instance
    * Installs ansible, awscli, python-pip and boto as EC2 comes up (cloud-init/userdata)
    * Gets required install packages from GIT

2.	Once the build-host is available, user should provide their respective AWS credentials using awscli. Detailed procedure is furnished below in the document.
3.  The ansible framework on the host triggers required tasks to provision the cluster on AWS.

## Usage

1. Download the CloudFormation template from the location below to the local machine

   wget https://raw.githubusercontent.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/master/CFormation-BHost-K8S-      Flannel.yaml#
