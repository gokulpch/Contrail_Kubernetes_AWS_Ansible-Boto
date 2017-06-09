#!/bin/bash
clear

read -p "Press [Enter] key to Execute Next Command..."

for i in `seq 1 5`;do echo;done

printf "\e[93mdocker ps | grep contrail\e[0m"

for i in `seq 1 5`;do echo;done

printf "\e[44mThis displays all the Contrail Control Plane Components on the Master\e[0m"

for i in `seq 1 5`;do echo;done

docker ps | grep contrail

for i in `seq 1 5`;do echo;done

read -p "Press [Enter] key to Execute Next Command..."

for i in `seq 1 5`;do echo;done

printf "\e[93mdocker exec -it controller contrail-status\e[0m"

for i in `seq 1 5`;do echo;done

printf "\e[44mThis displays status of Contriail-Services running on the Contrail-Controller container\e[0m"

for i in `seq 1 5`;do echo;done

docker exec -it controller contrail-status

for i in `seq 1 5`;do echo;done

read -p "Press [Enter] key to Execute Next Command..."

for i in `seq 1 5`;do echo;done

printf "\e[93mdocker exec -it analytics contrail-status\e[0m"

for i in `seq 1 5`;do echo;done

printf "\e[44mThis displays status of Contriail-Services running on the Contrail-Analytics container\e[0m"

for i in `seq 1 5`;do echo;done

docker exec -it analytics contrail-status

for i in `seq 1 5`;do echo;done

read -p "Press [Enter] key to Execute Next Command..."

for i in `seq 1 5`;do echo;done

printf "\e[93mdocker exec -it analyticsdb contrail-status\e[0m"

for i in `seq 1 5`;do echo;done

printf "\e[44mThis displays status of Contriail-DB-Services running on the Contrail-AnalyticsDB container\e[0m"

for i in `seq 1 5`;do echo;done

docker exec -it analyticsdb contrail-status

for i in `seq 1 5`;do echo;done

read -p "Press [Enter] key to Execute Next Command..."

for i in `seq 1 5`;do echo;done

printf "\e[93mdocker exec -it contrail-kube-manager contrail-status\e[0m"

for i in `seq 1 5`;do echo;done

printf "\e[44mThis displays status of Contriail-Kube-Manager-Service\e[0m"

for i in `seq 1 5`;do echo;done

docker exec -it contrail-kube-manager contrail-status

for i in `seq 1 5`;do echo;done

read -p "Press [Enter] key to Execute Next Command..."

for i in `seq 1 5`;do echo;done

printf "\e[93mdocker exec -it controller journalctl -f -u contrail-api\e[0m"

for i in `seq 1 5`;do echo;done

printf "\e[44mThis tails the logs of Contrail-Api service on the Controller. User cal check the logs of
              all contriail services using "journalctl -u <service_name>"\e[0m"

for i in `seq 1 5`;do echo;done

docker exec -it controller journalctl -f -u contrail-api

for i in `seq 1 5`;do echo;done

read -p "Press [Enter] key to Execute Next Command..."

for i in `seq 1 5`;do echo;done

printf "\e[93mdocker exec -it controller journalctl -f -u contrail-api\e[0m"

for i in `seq 1 5`;do echo;done

printf "\e[44mThis tails the logs of Contrail-Api service on the Controller. User cal check the logs of
              all contriail services using "journalctl -u <service_name>"\e[0m"

for i in `seq 1 5`;do echo;done

docker exec -it controller journalctl -f -u contrail-api

for i in `seq 1 5`;do echo;done
