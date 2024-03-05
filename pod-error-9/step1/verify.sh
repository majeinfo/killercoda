#!/bin/bash

REPLICAS=$(kubectl get deploy nginx -o jsonpath='{.items[0].status.availableReplicas}')
if [ "$REPLICAS" != "3" ]; then
	exit 1
fi

