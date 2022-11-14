#!/usr/bin/env bash

#import the license_key and host from args
#----------------------------------------
if [ $# -ne 2 ]; then
    echo $0: usage: bash install.sh license_key host
    exit 1
fi

echo ---Linux RocketAgent Installation----

license_key=$1
echo "License key:" $license_key

host=$2
echo "Host:" $host

#check if the service is running.
SERVICE="rocketcyber.service"

if systemctl is-active --quiet rocketcyber.service
then
    echo "$SERVICE is running"
else
    echo "$SERVICE stopped"
fi

#create installation directory
#-----------------------------
targetDir=/usr/local/rocketcyber

if [[ ! -e $targetDir ]]; then
     mkdir $targetDir
elif [[ ! -d $targetDir ]]; then
    echo "$targetDir already exists but is not a directory" 1>&2
fi
echo "Installation directory created."

#pulldown the rocketagent executable
#-------------------------------------------
rocketagentExecutable=${targetDir}/linux-rocketagent

echo URL: ${host}api/customers/${license_key}/supports/linux-rocketagent

curl -sL ${host}api/customers/${license_key}/supports/linux-rocketagent -o ${rocketagentExecutable}

if [ ! -f ${rocketagentExecutable} ]; then
    echo "linux rocketagent download failed!"
    exit 1
fi

echo "linux rocketagent download successful!"

#restore execute permissions
#---------------------------
 /bin/chmod 755 ${targetDir}/linux-rocketagent
echo "linux rocketagent permissions restored !"

#create launch command
#----------------------
rAgent="${targetDir}/linux-rocketagent"
rArgs=" --install --url ${host} --license_key ${license_key} --verbosity=1 --optsave  --service true"
rLaunch="${rAgent} ${rArgs}"

#launch the agent
#----------------
echo "Launching ${rLaunch}"
eval ${rLaunch}