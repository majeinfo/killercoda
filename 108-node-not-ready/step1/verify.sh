#!/bin/bash

STATE=$(kubectl get po nginx -o jsonpath='{.status.phase}')

if [ "$STATE" != "Running" ]; then
	exit 1
fi

STATE=$(kubectl get no controlplane -o jsonpath='{.spec.taints[0].key}')
if [ "$STATE" != "" ]; then
	exit 1
fi

if ! grep 6443 /etc/kubernetes/kubelet.conf; then
	exit 1
fi
