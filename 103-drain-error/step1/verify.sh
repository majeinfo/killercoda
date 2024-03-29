#!/bin/bash

UNSCHED=$(kubectl get no node01 -o jsonpath='{.spec.unschedulable}')

if [ "$UNSCHED" != "true" ]; then
	exit 1
fi

REPL=$(kubectl get deploy nginx -o jsonpath='{.status.readyReplicas}')

if [ "$REPL" != "2" ]; then
	exit 1
fi

NODE=$(kubectl get po -o jsonpath='{.items[0].spec.nodeName}')
if [ "$NODE" != "controlplane" ]; then
	exit 1
fi

NODE=$(kubectl get po -o jsonpath='{.items[1].spec.nodeName}')
if [ "$NODE" != "controlplane" ]; then
	exit 1
fi
