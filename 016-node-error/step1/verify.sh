#!/bin/bash

STATUS=$(kubectl get po worker -o jsonpath='{.status.phase}')
if [ "$STATUS" != "Running" ]; then
	exit 1
fi

AVAILSZ=$(df --output=avail / | tail -1)
if [ "$AVAILSZ" = "" -o $AVAILSZ -lt 2000000 ]; then
	exit 1
fi

