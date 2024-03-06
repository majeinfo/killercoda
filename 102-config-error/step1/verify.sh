#!/bin/bash

PODMYSQL=$(kubectl get po mysqlsrv -o jsonpath='{.status.phase}')

if [ "$PODMYSQL" != "Running" ]; then
	exit 1
fi

SECRET=$(kubectl get secret mysql-secret -o jsonpath='{.data.ROOT_PASSWORD}' | base64 -d)
if [ "$SECRET" != "password" ]; then
	exit 1
fi

