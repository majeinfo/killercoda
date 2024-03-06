# Wrong tolerations for DaemonSet !

cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: myagent
spec:
  selector:
    matchLabels:
      app: agent
  template:
    metadata:
      labels:
        app: agent
    spec:
      containers:
        - name: agent
          image: busybox
          command: ["/bin/sleep", "1000"]
EOF

touch /tmp/finished
