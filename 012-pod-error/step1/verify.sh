#!/bin/bash

PHASE=$(kubectl get po mysqlsrv -o jsonpath='{.status.phase}')
if [ "$PHASE" != "Running" ]; then
	exit 1
fi

ENVNAME=$(kubectl get po mysqlsrv -o jsonpath='{.spec.containers[0].env[0].name}')
if [ "$ENVNAME" != "MYSQL_ROOT_PASSWORD" -a "$ENVNAME" != "MYSQL_ALLOW_EMPTY_PASSWORD" -a "$ENVNAME" != "MYSQL_RANDOM_ROOT_PASSWORD" ]; then
	exit 1
fi
