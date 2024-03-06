#!/bin/bash

PHASE=$(kubectl get po web -o jsonpath='{.status.phase}')
if [ "$PHASE" != "Running" ]; then
	exit 1
fi

PODIP=$(kubectl get po web -o jsonpath='{.status.podIP}')
curl "$PODIP" -o- | grep "Well done"
if [ $? -ne 0 ]; then
	exit 1
fi
