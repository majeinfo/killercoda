#!/bin/bash

STATUS=$(kubectl get po nginx -o jsonpath='{.status.phase}')
if [ "$STATUS" != "Running" ]; then
	exit 1
fi

