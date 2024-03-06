# Wrong podAntiAffinity !

NODE=$(kubectl get no -o jsonpath='{.items[0].metadata.name}')
kubectl taint node "$NODE" node-role.kubernetes.io/control-plane:NoSchedule-

cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  namespace: default
spec:
  progressDeadlineSeconds: 600
  replicas: 2
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: nginx
    spec:
      nodeName: "$NODE"
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        resources: {}
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
EOF

touch /tmp/finished
