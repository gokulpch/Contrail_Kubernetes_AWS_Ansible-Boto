# Contrail_Kubernetes_AWS_Ansible-Boto
Contrail CNI-Kubernetes with Containarized Control Plane on AWS

<p align="center">
  <br><br>
  <img src="http://www.juniper.net/assets/img/dm/interoptokyo2016/opencontrail.png">
  <img src="https://raw.githubusercontent.com/kubernetes/kops/master/docs/img/k8s-aws.png">
</p>
                
Opencontrail adds network functionality to Kubernetes with additional functionalities such as multi-tenancy, network isolation, micro-segmentation with network policies, load-balancing etc.

Opencontrail maps the following k8s concepts into opencontrail resources:

   * Namespace:	Shared or single project based on configuration
   * Pod:	Virtual-machine, Interface, Instance-ip
   * Service:	ECMP based native Loadbalancer
   * Ingress:	Haproxy based L7 Loadbalancer for URL routing
   * Network Policy:	Security group based on namespace and pod selectors

Opencontrail can be configured in the following mode in a K8s cluster:

   * Default
   * Namespace isolation (with or without service isolation)
   * Custom (define network for a pod, namespace)
   * Nested (k8s cluster in openstack virtual-machines
   
Beta:

   * Contrail-Helm
   * Single YAML install (similar to all other opensource CNI deployment)
   * These enable easy integration of contrail with other deployment frameworks such as KOPS, HEPTIO etc.

## Provisioning Contrail with Kubernetes using Ansible & Python-Boto on Amazon Web Services

Ansible’s EC2 module uses python-boto library to call AWS API, and boto needs AWS credentials in order to function.

The solution is organized in 3 parts:

   * A generic Ansible role that uses ec2 module to provision
   * Yaml files with variables that will be used as parameters for each type of EC2 host
   * Playbook that combines the variables file with the role

## Prerequisites

* ansible 
* awscli
* python-pip
* boto
* AWS account which can allow users to use Large and Medium EC2 instances (Usually not available in free-tier)
* AWS account access and secret keys

## Procedure

1.  A CloudFormation template is used to create a build-host which has all the packages required as specified above (ansible, awcli, python-pip and boto), this includes the repo with ansible-framework required to provision the cluster.

    * Creates VPC, Subnet, EC2 Instance
    * Installs ansible, awscli, python-pip and boto as EC2 comes up (cloud-init/userdata)
    * Gets required install packages from GIT

2.  Once the build-host is available, user should provide their respective AWS credentials using awscli. Detailed procedure is furnished below in the document.
3.  The ansible framework on the host triggers required tasks to provision the cluster on AWS.

## Usage

1. Choose the Region from AWS web portal. For consistency and mapping of AMI's used in the template select **US-West(Oregon)**

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws-16.png)

2. Download the CloudFormation template from the location below to the local machine

   wget https://raw.githubusercontent.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/master/CFormation-BHost-K8S-Contrail.json#

3. Select CloudFormation service from AWS web portal 

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws1.png)

4. Select “Create Stack” Option
 
    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws2.png)
    
5. Select Upload a template and choose the file downloaded above
 
    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws3.png)
    
6. Provide a “Stack Name”

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws-17.png)
    
7. As we are not enabling any IAM access or select “Next” and “Create” in the review page to initiate the stack.

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws5.png)
    
    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws6.png)

8. Watch for the stack to complete

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws7.png)
     
9. Once the stack creation is complete then proceed to the EC2 (from “services” and select the “running instances”)dashboard      to get the public_ip of the instance. Select the instance with the name that have been provided in step.5 and you can get      the public_ip as shown below.

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws8.png)
    
10. Use “root@<public_ip>”, “Password: contrail1” to access the instance from the local terminal and you should see directory      named “Contrail_Kubernetes_AWS_Ansible-Boto” in “/root”

11. Get the access key and secret from AWS portal. Instructions are mentioned below:

    a. Select “My Security Credentials”
    
       ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws9.png)
       
    b. Select “Access Keys (Access Key ID and Secret Access Key)”
    
       ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws10.png)
       
    c. Select “Create New Access Key” and choose “Download File”
    
       ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws11.png)

12. In the Build-Host instance created above use  **“aws configure”** to configure the access details. The CLI will prompt the         user to provide the keys one by one.

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws12.png)
       
    Provide the credentials from the csv file downloaded above and select **“us-west-2”** as the default region

13. Enter the directory and run:

    ```
     ./create_key_pair.sh      #Creates a Key_Pair required by ansible initially to login
     ./create_cluster.sh       #Triggers the ansible tasks to create the cluster
    
    ```
14. Once Ansible completes the provisioning user can see **“contrail-K8S-Master”** and **“contrail-K8S-Node”** on the EC2         dashboard with Contrail, Kubernetes-Master and Node installed.

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws-15.png)

15. User can enter the terminal (master and node) using the   public_ip **“root@<public_ip>”** **"password: contrail1"**.         Refer step.8 for the details on getting the public_ip.

16. To access the Contrail Web-UI **"https://<public_ip_contrail-K8S-Master>:8143"**, Credentials:admin/contrail123

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws-Contrail-UI.png)

17. To access the Kubernetes Web-UI **"http://<public_ip_contrail-K8S-Node>:9090"**, no credentials needed

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws-K8S-UI.png)

18. To Delete all the components on AWS (VPC, IGW, Subnets, EC2 etc.) use delete_cluster in **“Kubernetes_AWS_Flannel_Ansible-BOTO”** directory, run:

      ```
         ./ delete_cluster.sh      #Deletes the cluster
    
      ```

### Ansible - Specific Usage (not a part of regular install)

In case of script failures, users can start, exclude/include tasks:

a.  To run specifc tasks example : “upgrade” and “installdocker” part of the playbook

```ansible-playbook example.yml --tags "configuration,packages"```

b. Run a playbook without certain tasks

```ansible-playbook example.yml --skip-tags "notification"```

### For Sample_YAML files and some Click_Through Scripts

Clone the following repository to the Desktop if using the Kubernetes Dashboard to upload the YAML file. If users are using CLI these are pre-packaged and available on Master

git clone https://github.com/gokulpch/Contrail_Kubernetes_Demo_Yaml

## Demo Video

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/KL0E4SaRCs0/0.jpg)](https://youtu.be/KL0E4SaRCs0)

#### License

This project is licensed under the **MIT** License - see the [LICENSE.md](LICENSE.md) file for details

#### Authors

* **Gokul Chandra** - (https://github.com/gokulpch)
