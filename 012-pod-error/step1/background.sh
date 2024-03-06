# Missing envvar !

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: mysqlsrv
  namespace: default
spec:
  containers:
    - image: mysql:5.7
      imagePullPolicy: Always
      name: mysqlsrv
      resources:
        limits:
          memory: 768Mi
        requests:
          memory: 768Mi
  restartPolicy: Always
EOF

touch /tmp/finished
