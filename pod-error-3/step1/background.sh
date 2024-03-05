# Wrong tolerations !

NODE=$(kubectl get no -o jsonpath='{.items[0].metadata.name}')
kubectl taint node "$NODE" challenge=true:NoExecute

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: web
  namespace: default
spec:
  containers:
  - image: nginx:1.8
    imagePullPolicy: IfNotPresent
    name: web
  restartPolicy: Always
EOF

touch /tmp/finished
