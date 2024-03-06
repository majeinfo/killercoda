# Wrong label on node !

kubectl taint node controlplane only-available-for=ai:NoExecute

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
  restartPolicy: Always
EOF

touch /tmp/finished
