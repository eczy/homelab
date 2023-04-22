#!/usr/bin/env bash

for FILE in tsa_host_key worker_key session_signing_key
do
    if [ -f $FILE ];
    then
        echo "$FILE already exists. Exiting."
        exit 1
    fi
    ssh-keygen -t rsa -b 4096 -m PEM -N "" -f $FILE <<< n
done
rm session_signing_key.pub
