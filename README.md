# Contrail_Kubernetes_AWS_Ansible-Boto
Contrail CNI-Kubernetes with Containarized Control Plane on AWS

### Provisioning Kubernetes with Flannel using Ansible & Python-Boto on Amazon Web Services

Ansible’s EC2 module uses python-boto library to call AWS API, and boto needs AWS credentials in order to function.

The solution is organized in 3 parts:

•	A generic Ansible role that uses ec2 module to provision
•	Yaml files with variables that will be used as parameters for each type of EC2 host
• Playbook that combines the variables file with the role
