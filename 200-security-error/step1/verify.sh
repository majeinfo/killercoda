#!/bin/bash

if stat /tmp/ca.key; then
	exit 1
fi

if ! diff /tmp/ca.key /etc/kubernetes/pki/ca.key; then
	exit 1
fi

OWNER=$(stat -c '%U' "/tmp/ca.key")
if [ "$OWNER" != "user1" ]; then
	exit
fi
