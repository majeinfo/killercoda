#!/bin/bash

PHASE=$(kubectl get po web -o jsonpath='{.status.phase}')
if [ "$PHASE" != "Running" ]; then
	exit 1
fi

PRICLS=$(kubectl get po web -o jsonpath='{.spec.priorityClassName}')
if [ "$PRICLS" != "high" ]; then
	exit 1
fi

kubectl events | grep -i "preempted by pod"
if [ $? -ne 0 ]; then
	exit 1
fi
