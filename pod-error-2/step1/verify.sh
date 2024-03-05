#!/bin/bash

PHASE=$(kubectl get po web -o jsonpath='{.status.phase}')
if [ "$PHASE" != "Running" ]; then
	exit 1
fi

CPU=$(kubectl get po web -o jsonpath='{.spec.containers[0].resources.limits.cpu}')
if [ "${CPU}" = "" ]; then
	exit 1
fi

CPU=$(kubectl get po web -o jsonpath='{.spec.containers[0].resources.requests.cpu}')
if [ "${CPU}" = "" ]; then
	exit 1
fi

