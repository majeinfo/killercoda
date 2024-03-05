#!/bin/bash

NODE=$(kubectl get no -o jsonpath='{.items[0].metadata.name}')

PHASE=$(kubectl get po web -o jsonpath='{.status.phase}')
if [ "$PHASE" != "Running" ]; then
	exit 1
fi

TAINTS=$(kubectl get no "$NODE" -o jsonpath='{.spec.taints}')
echo "$TAINTS" | grep "challenge"
if [ $? -ne 0 ]; then
	exit 1
fi

