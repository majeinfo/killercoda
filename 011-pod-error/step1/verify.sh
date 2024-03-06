#!/bin/bash

TAINT=$(kubectl get no controlplane -o jsonpath='{.spec.taints[0].key}')
if [ "$TAINT" != "only-available-for" ]; then
	exit 1
fi

PHASE=$(kubectl get po web -o jsonpath='{.status.phase}')
if [ "$PHASE" != "Running" ]; then
	exit 1
fi

TOLERATION=$(kubectl get po web -o jsonpath='{.spec.tolerations[0].key}')
if [ "$TOLERATION" != "only-available-for" ]; then
	exit 1
fi
