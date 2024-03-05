# Wrong user !

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
    securityContext:
      privileged: false
      runAsUser: 104
      runAsGroup: 107
  restartPolicy: Always
EOF

touch /tmp/finished
