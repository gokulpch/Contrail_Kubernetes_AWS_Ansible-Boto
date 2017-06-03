#!/bin/bash
#!/bin/bash
############################################################################
######
##########Runs Ansible to create a Keypair and saves the same to ~/.ssh on the local machine#########
######
############################################################################
echo "Running Ansible playbook to create a Keypair..............."
echo ""
echo ""
echo "**************************************************************************************"
ansible-playbook /root/Contrail_Kubernetes_AWS_Ansible-Boto/ansible/create_keypair.yml
echo "Copying Keypair.pem to local machine..............."
eval `ssh-agent -s`;
ssh-add ~/.ssh/contrailK8S-keypair.pem;
bash -i
