#!/bin/bash

NODE1=$(kubectl get po -o jsonpath='{.items[0].spec.nodeName}')
NODE2=$(kubectl get po -o jsonpath='{.items[1].spec.nodeName}')

PHASE1=$(kubectl get po -o jsonpath='{.items[0].status.phase}')
PHASE2=$(kubectl get po -o jsonpath='{.items[1].status.phase}')

if [ "$PHASE1" != "Running" -o "$PHASE2" != "Running" ]; then
	exit 1
fi

if [ "$NODE1" = "$NODE2" ]; then
	exit 1
fi

