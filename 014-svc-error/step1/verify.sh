#!/bin/bash

IP1=$(kubectl get endpoints nginx -o jsonpath='{.subsets[0].addresses[0].ip}')
IP1=$(kubectl get endpoints nginx -o jsonpath='{.subsets[2].addresses[0].ip}')

if [ "$IP1" = "" -o "$IP2" = "" ]; then
	exit 1
fi

CLUSTERIP=$(kubectl get svc nginx -o jsonpath='{.spec.clusterIP}')
curl "$CLUSTERIP"
if [ $? -ne 0 ]; then
	exit 1
fi

