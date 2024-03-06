#!/bin/bash

QUOTA=$(kubectl get resourcequota default-quota -o jsonpath='{.spec.hard.limits\.cpu}')
if [ "$QUOTA" != "800m" ]; then
	exit 1
fi

QUOTA=$(kubectl get resourcequota default-quota -o jsonpath='{.spec.hard.limits\.memory}')
if [ "$QUOTA" != "800Mi" ]; then
	exit 1
fi

PHASE=$(kubectl get po frontend -o jsonpath='{.status.phase}')
if [ "$PHASE" != "Running" ]; then
	exit 1
fi

QUOTA=$(kubectl get pod frontend -o jsonpath='{.spec.containers[0].resources.limits.memory}')
if [ "$QUOTA" != "256Mi" ]; then
	exit 1
fi

PHASE=$(kubectl get po web -o jsonpath='{.status.phase}')
if [ "$PHASE" != "Running" ]; then
	exit 1
fi

