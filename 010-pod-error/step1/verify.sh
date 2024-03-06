#!/bin/bash

LABEL=$(kubectl get no controlplane -o jsonpath='{.metadata.labels.disktype}')
if [ "$LABEL" != "ssd" ]; then
	exit 1
fi

PHASE=$(kubectl get po web -o jsonpath='{.status.phase}')
if [ "$PHASE" != "Running" ]; then
	exit 1
fi
