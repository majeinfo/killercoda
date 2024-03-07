#!/bin/bash

SVC=$(kubectl get svc vote -o jsonpath='{.spec.clusterIP}')

curl http://$SVC
if [ $? -ne 0 ]; then
	exit 1
fi

NBREPL=$(kubectl get vote -o jsonpath='status.readyReplicas')
if [ "$NBREPL" -ne "1" ]; then
	exit 1
fi

