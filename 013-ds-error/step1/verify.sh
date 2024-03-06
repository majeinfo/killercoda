#!/bin/bash

COUNT=$(kubectl get ds myagent -o jsonpath='{.status.currentNumberScheduled}')
DESIRED=$(kubectl get ds myagent -o jsonpath='{.status.desiredNumberScheduled}')

if [ "$COUNT" != "2" -o "$DESIRED" != "2" ]; then
	exit 1
fi

