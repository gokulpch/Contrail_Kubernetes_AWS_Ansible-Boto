#!/bin/bash

############################################################################
######                      ######                                    ######
##########Delete All AWS Components VPC, Subnets, IGW, EC2, Volumes#########
######                      ######                                    ######
############################################################################

# vpc name
name=contrailk8s-vpc

# query for vpc idvpc
vpc=$(aws ec2 describe-vpcs --filters "Name=tag-value,Values=${name}" --output text --query "Vpcs[].VpcId")

# default filter
filter="Name=vpc-id,Values=${vpc}"

echo "terminate all instances in your VPC"
#instance_ids=$(aws ec2 describe-instances --filters $filter --output text --query "Reservations[].Instances[].InstanceId")

#for instance in ${instance_ids}; do
#  echo "stopping instance: ${instance}"
#  sleep 30
#  aws ec2 stop-instances --instance-ids $instance --output text

#  volume_ids=$(aws ec2 describe-volumes --filters "Name=attachment.instance-id,Values=${instance}" --output text --query "Volumes[].VolumeId")

#  for volume in ${volume_ids}; do
#    echo "detaching volume: ${volume}"
#    aws ec2 detach-volume --volume-id $volume --output text
#    echo "deleting volume: ${volume}"
#    aws ec2 delete-volume --volume-id $volume --output text
#  done

#  echo "terminating instance: ${instance}"
#  aws ec2 terminate-instances --instance-ids $instance --output text
#done

aws ec2 describe-instances --filters "Name=tag:Name,Values=contrail-K8S-Master" | grep InstanceId | cut -d':' -f2 | tr -d '",' | xargs -I '{}' aws ec2 terminate-instances --instance-ids '{}'
aws ec2 describe-instances --filters "Name=tag:Name,Values=contrail-K8S-Minion" | grep InstanceId | cut -d':' -f2 | tr -d '",' | xargs -I '{}' aws ec2 terminate-instances --instance-ids '{}'

echo "*********..........Deleting Master Instance...........*************"
sleep 80

echo "*********..........Deleting Minion Instance...........*************"
eni_ids=$(aws ec2 describe-network-interfaces --filters $filter --output text --query "NetworkInterfaces[].NetworkInterfaceId")

for eni in ${eni_ids}; do
  echo "delete network interface: ${eni}"
  aws ec2 delete-network-interface --network-interface-id $eni
done

echo "*********..........Waiting for the instances to Terminate...........***********"
association_ids=$(aws ec2 describe-route-tables --filters $filter --output text --query "RouteTables[].Associations[].RouteTableAssociationId")

for association in ${association_ids}; do
  echo "delete route table association: ${association}"
  aws ec2 disassociate-route-table --association-id $association > /dev/null 2>&1
done

echo "*********..........Delete all ENI's associated with subnets within your VPC...........***********"
route_table_ids=$(aws ec2 describe-route-tables --filters $filter --output text --query "RouteTables[].RouteTableId")

for route_table in ${route_table_ids}; do
  echo "delete route table: ${route_table}"
  aws ec2 delete-route-table --route-table-id $route_table > /dev/null 2>&1
done

echo "delete all internet gateways"
gateway_ids=$(aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=${vpc}" --output text --query "InternetGateways[].InternetGatewayId")

for gateway in ${gateway_ids}; do
  echo "detach internet gateway: ${gateway}"
  aws ec2 detach-internet-gateway --internet-gateway-id $gateway --vpc-id $vpc
  echo "delete internet gateway: ${gateway}"
  aws ec2 delete-internet-gateway --internet-gateway-id $gateway
done

echo "disassociate all Network ACL's from all the subnets in your VPC"
# acl_ids=$(aws ec2 describe-network-acls --filters $filter --output text --query "NetworkAcls[].NetworkAclId")

# for acl in ${acl_ids}; do
#   echo "delete route table: ${acl}"
#   aws ec2 delete-network-acl --network-acl-id $acl
# done

echo "delete all Network ACL's other than the Default one"
acl_ids=$(aws ec2 describe-network-acls --filters $filter --output text --query "NetworkAcls[].NetworkAclId")

for acl in ${acl_ids}; do
  echo "delete network acl: ${acl}"
  aws ec2 delete-network-acl --network-acl-id $acl > /dev/null 2>&1
done

echo "delete all Security groups other than the Default one (note: if one group has a rule that references another, you have to delete that rule before you can delete the other security group)"
security_group_ids=$(aws ec2 describe-security-groups --filters $filter --output text --query "SecurityGroups[].GroupId")

for security_group in ${security_group_ids}; do
  echo "delete network acl: ${security_group}"
  aws ec2 delete-security-group --group-id $security_group > /dev/null 2>&1
done

echo "delete all subnets"
subnet_ids=$(aws ec2 describe-subnets --filters $filter --output text --query "Subnets[].SubnetId")

for subnet in ${subnet_ids}; do
  echo "delete subnet: ${subnet}"
  aws ec2 delete-subnet --subnet-id $subnet
done

echo "delete your VPC"
aws ec2 delete-vpc --vpc-id $vpc

echo "delete any DHCP Option Sets that had been used by the VPC"
# done manually, could not determine how to query by vpc

echo "delete Key-Pair"
aws ec2 delete-key-pair --key-name contrailK8S-keypair
