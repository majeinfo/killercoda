#!/bin/bash

SVC=$(kubectl get svc vote -o jsonpath='{.spec.clusterIP}')

curl http://$SVC
if [ $? -ne 0 ]; then
	exit 1
fi

curl -XPOST http://$SVC -d "option=a" | grep "500"
if [ $? -ne 0 ]; then
	exit 1
fi

kubectl get netpol default-deny
if [ $? -ne 0 ]; then
	exit 1
fi

PODSEL=$(kubectl get netpol default-deny -o jsonpath='{.spec.podSelector}')
if [ "$PODSEL" != "{}" ]; then
	exit 1
fi

GEN=$(kubectl get netpol default-deny -o jsonpath='{.metadata.generation}')
if [ "$GEN" != "1" ]; then
	exit 1
fi
