# Wrong resources requests !

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
    resources:
      limits:
        memory: "128Mi"
	cpu: "300"
      requests:
        memory: "128Mi"
	cpu: "200"
  restartPolicy: Always
EOF

touch /tmp/finished
