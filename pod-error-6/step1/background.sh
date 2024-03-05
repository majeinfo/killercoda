# Wrong quota !

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ResourceQuota
metadata:
  name: default-quota
spec:
  hard:
    requests.cpu: "500m"
    requests.memory: 500Mi
    limits.cpu: "800m"
    limits.memory: 800Mi
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: frontend
  namespace: default
spec:
  containers:
  - image: nginx:1.8
    imagePullPolicy: IfNotPresent
    name: frontend
    resources:
      limits:
        memory: 256Mi
        cpu: 512m
      requests:
        memory: 256Mi
        cpu: 256m
  restartPolicy: Always
EOF

touch /tmp/finished
