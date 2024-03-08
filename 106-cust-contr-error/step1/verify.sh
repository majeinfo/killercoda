#!/bin/bash

CMVALUE=$(kubectl get cm frontend-config -o jsonpath='{.data.config\.cfg}')
VALUE=$(echo $CMVALUE | cut -d= -f2)
if [ "$VALUE" = '"Welcome to Kubernetes"' ]; then
	exit 1
fi

IND=0
while true; do
	POD=$(kubectl get po -o jsonpath="{.items[$IND].metadata.name}")
	if [ "$POD" = "" ]; then
		exit 1
	fi
	if [[ "$POD" =~ cuscon.* ]]; then
		break
	fi
	IND=$[ $IND + 1]
done

PODIP=$(kubectl get po $POD -o jsonpath='{.status.podIP}')

curl $PODIP | grep -- "$VALUE"
if [ $? -ne 0 ]; then
	exit 1
fi

PRIV=$(kubectl auth can-i watch cm --as=system:serviceaccount:default:configmap-watcher)
if [ "$PRIV" != "yes" ]; then
	exit 1
fi

PRIV=$(kubectl auth can-i delete pods --as=system:serviceaccount:default:configmap-watcher)
if [ "$PRIV" != "yes" ]; then
	exit 1
fi

