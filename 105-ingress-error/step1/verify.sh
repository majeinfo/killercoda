#!/bin/bash

SVC=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.spec.clusterIP}')

curl -H "Host: vote1" http://$SVC | grep "#hostname"
if [ $? -eq 0 ]; then
	exit 1
fi

curl -H "Host: vote2" http://$SVC | grep "#hostname"
if [ $? -ne 0 ]; then
	exit 1
fi

