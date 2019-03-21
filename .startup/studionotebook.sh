#!/bin/bash

set -x

IP=$(ifconfig | awk '/inet/ { print $2 }' | egrep -v '^fe|^127|^192|^172|::' | head -1)
IP=${IP#addr:}

if [[ $HOSTNAME == "node"* ]] ; then
    #rightscale
    IP=$(grep $(hostname)_ext /etc/hosts | awk '{print $1}')
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    IP=localhost
fi

# Swap out your file name here
curl -H "Accept-Encoding: gzip" -X POST -F 'file=@notebooks/Data_Modeling_Workshop_-_Sprint_01.tar' http://"$IP":9091/api/v1/notebooks/import &> /dev/null
curl -H "Accept-Encoding: gzip" -X POST -F 'file=@notebooks/Data_Modeling_Workshop_-_Sprint_02.tar' http://"$IP":9091/api/v1/notebooks/import &> /dev/null
curl -H "Accept-Encoding: gzip" -X POST -F 'file=@notebooks/Data_Modeling_Workshop_-_Sprint_03.tar' http://"$IP":9091/api/v1/notebooks/import &> /dev/null
curl -H "Accept-Encoding: gzip" -X POST -F 'file=@notebooks/Data_Modeling_Workshop_-_Sprint_04.tar' http://"$IP":9091/api/v1/notebooks/import &> /dev/null