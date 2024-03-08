#!/bin/bash

STATUS=$(kubectl get po nginx -o jsonpath='{.status.phase}')
if [ "$STATUS" != "Running" ]; then
	exit 1
fi

UNSCHED=$(kubectl get no controlplane -o jsonpath='{.spec.unschedulable}')
if [ "$UNSCHED" = "true" ]; then
	exit 1
fi


