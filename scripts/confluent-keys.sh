#!/bin/sh

if [ -z "$CONFLUENT_API_KEY" -o -z "$CONFLUENT_API_SECRET" ]
then
    echo "Confluent keys not in environment"
    echo "Bye"
    exit 1
fi

kubectl create secret generic tf-confluent-keys \
    -n flux-system \
    --from-literal=access_key=$CONFLUENT_API_KEY \
    --from-literal=secret_key=$CONFLUENT_API_SECRET