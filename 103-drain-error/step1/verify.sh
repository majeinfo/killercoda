#!/bin/bash

UNSCHED=$(kubectl get no node01 -o jsonpath='{.spec.unschedulable}')

if [ "$UNSCHED" != "true" ]; then
	exit 1
fi

REPL=$(kubectl get deploy nginx -o jsonpath='{.status.readyReplicas}')

if [ "$REPL" != "2" ]; then
	exit 1
fi
