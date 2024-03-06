#!/bin/bash

PHASE=$(kubectl get po web -o jsonpath='{.status.phase}')
if [ "$PHASE" != "Running" ]; then
	exit 1
fi

RUNAS=$(kubectl get po web -o jsonpath='{.spec.containers[0].securityContext.runAsUser}')
if [ "$RUNAS" != "0" ]; then
	exit 1
fi

