#!/bin/bash
crossAccountRole="arn:aws:iam::xxxxxxxxxxxx:role/roleName"
stsCreds=$(aws sts assume-role --role-arn $crossAccountRole --role-session-name stsSession | grep "\":\ \"" | sed 's/"//g' | sed 's/ //g' | sed 's/,//g')
for line in $stsCreds 
do
  key=$(echo $line | awk -F":" '{print $1}')
  value=$(echo $line | awk -F":" '{print $2}')
  export $key=$value
done

awsConfigure="aws configure set aws_access_key_id $AccessKeyId && aws configure set aws_secret_access_key $SecretAccessKey && aws configure set aws_session_token $SessionToken"
$(awsConfigure)
