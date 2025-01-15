#!/bin/bash

IMG=$(kubectl get po -o jsonpath='{.items[0].spec.containers[0].image}')

if [ "$IMG" != "nginx" ]; then
	exit 1
fi
