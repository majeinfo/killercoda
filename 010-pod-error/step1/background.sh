# Wrong label on node !

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: web
  namespace: default
spec:
  containers:
  - image: nginx
    imagePullPolicy: Always
    name: nginx
    resources:
      limits:
        memory: 256Mi
      requests:
        memory: 256Mi
  nodeSelector:
    disktype: ssd
  restartPolicy: Always
EOF

touch /tmp/finished
