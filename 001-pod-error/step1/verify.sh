#!/bin/bash

IMAGE=$(kubectl get po web -o jsonpath='{.spec.containers[0].image}')
if [ "${IMAGE%:*}" != "nginx" ]; then
	exit 1
fi

PHASE=$(kubectl get po web -o jsonpath='{.status.phase}')
if [ "$PHASE" != "Running" ]; then
	exit 1
fi
