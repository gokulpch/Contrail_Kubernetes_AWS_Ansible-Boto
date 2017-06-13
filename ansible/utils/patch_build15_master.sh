#!/bin/bash
###################################################################################################
######                                                                                        #####
#########     Temporary fix for Build 15..NTP start in Controller and  Agent containers       #####
######        Performing "service ntp start" in contrainers using docker exec        	      #####
###################################################################################################
#!/bin/bash
echo "starting ntp service in Controller container............"
docker exec -it controller service ntp restart
