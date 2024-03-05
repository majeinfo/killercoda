#!/bin/bash
# Wrong image name !
kubectl run web --image=ngninx:1.8
touch /tmp/finished
