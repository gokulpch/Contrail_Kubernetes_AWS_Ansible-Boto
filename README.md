
![alt text](http://talligent.com/wp-content/uploads/2015/10/Screen-Shot-2015-12-01-at-9.17.50-PM.png)![alt text](https://www.brandsoftheworld.com/sites/default/files/styles/logo-thumbnail/public/112012/amazon.com_web_services.png?itok=IbCS6QAe)![alt text](https://www.cncf.io/wp-content/uploads/sites/2/2017/05/logo_kubernetes.png)

# Contrail_Kubernetes_AWS_Ansible-Boto
Contrail CNI-Kubernetes with Containarized Control Plane on AWS

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

1. Download the CloudFormation template from the location below to the local machine

   wget https://raw.githubusercontent.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/master/CFormation-BHost-K8S-Contrail.json#

2. Select CloudFormation service from AWS web portal 

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws1.png)

3. Select “Create Stack” Option
 
    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws2.png)
    
4. Select Upload a template and choose the file downloaded above
 
    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws3.png)
    
5. Provide a “Stack Name” and “KeyPair” is optional (the template enable root access where there is no need of any key    to login once the instance is available) and select “Next”

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws4.png)
    
6. As we are not enabling any IAM access or select “Next” and “Create” in the review page to initiate the stack.

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws5.png)
    
    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws6.png)

7. Watch for the stack to complete

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws7.png)
     
8. Once the stack creation is complete then proceed to the EC2 (from “services” and select the “running instances”)dashboard      to get the public_ip of the instance. Select the instance with the name that have been provided in step.5 and you can get      the public_ip as shown below.

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws8.png)
    
9. Use “root@<public_ip>”, “Password: contrail1” to access the instance from the local terminal and you should see directory      named “Kubernetes_AWS_Flannel_Ansible-BOTO” in “/root”

10. Get the access key and secret from AWS portal. Instructions are mentioned below:

    a. Select “My Security Credentials”
    
       ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws9.png)
       
    b. Select “Access Keys (Access Key ID and Secret Access Key)”
    
       ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws10.png)
       
    c. Select “Create New Access Key” and choose “Download File”
    
       ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws11.png)

11. In the Build-Host instance created above use  “aws configure” to configure the access details. The CLI will prompt the         user to provide the keys one by one.

    ![alt text](https://github.com/gokulpch/Ansible_Base_Hosts_CloudFormation-Templates/blob/master/img/aws12.png)
       
    Provide the credentials from the csv file downloaded above and select “us-west-2” as the default region

12. Enter the directory and run:

    ```
     ./ create_key_pair.sh      #Creates a Key_Pair required by ansible initially to login
     ./ create_cluster.sh       #Triggers the ansible tasks to create the cluster
    
    ```
13. Once the ansible completes the provisioning the user can see a “contrail-K8S-Master” and “contrail-K8S-Node” on the EC2       dashboard with Kubernetes-Master and Node installed with Flannel networking. User can enter the terminal using the             public_ip “root@<public_ip>” "password: contrail1". Refer step.8 for the details on getting the public_ip.

#### License

This project is licensed under the **MIT** License - see the [LICENSE.md](LICENSE.md) file for details

#### Authors

* **Gokul Chandra** - *Initial work* - (https://github.com/gokulpch)
