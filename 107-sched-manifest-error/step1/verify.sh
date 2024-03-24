#!/bin/bash

if ! pidof kube-scheduler; then
	exit 1
fi

STATE=$(kubectl get po nginx -o jsonpath='{.status.phase}')

if [ "$STATE" != "Running" ]; then
	exit 1
fi

