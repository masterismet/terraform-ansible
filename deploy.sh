#!/bin/bash

# ./deploy.sh --app=test --environment=staging --num=2 --size=t2.micro

for i in "$@"
do
    case $i in
        --app=*)
            APP="${i#*=}"
            ;;
        --environment=*)
            ENVIRONMENT="${i#*=}"
            ;;
        --num=*)
            NUM="${i#*=}"
            ;;
        --size=*)
            SIZE="${i#*=}"
            ;;
        *)
            # unknown option
            ;;
    esac
done

terraform=$(which terraform)
ansible=$(which ansible-playbook)

#ssh-keygen -t rsa -b 4096 -f ./ansible-key -N ''

echo $terraform apply -var app_name=${APP} -var environment=${ENVIRONMENT} -var num_servers=${NUM} -var instance_type=${SIZE} terraform 
$terraform apply -var app_name=${APP} -var environment=${ENVIRONMENT} -var num_servers=${NUM} -var instance_type=${SIZE} -var ssh_key="$(cat ./pkey.p12)" terraform

echo '[wordpress]' > ansible/inventory

$terraform output public_ip | sed -e 's/,$//' >> ansible/inventory


echo $ansible -i ansible/inventory --key-file="./ansible-key" ansible/site.yml
$ansible -i ansible/inventory --key-file="./pkey.p12" ansible/site.yml 




