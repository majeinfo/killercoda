# Wrong prioryClass !

cat <<EOF | kubectl apply -f -
apiVersion: scheduling.k8s.io/v1
description: Pod with medium priority
kind: PriorityClass
metadata:
  generation: 1
  name: high
preemptionPolicy: PreemptLowerPriority
value: 2000
EOF

cat <<EOF | kubectl apply -f -
apiVersion: scheduling.k8s.io/v1
description: Pod with medium priority
kind: PriorityClass
metadata:
  generation: 1
  name: medium
preemptionPolicy: PreemptLowerPriority
value: 1000
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: pod1
  namespace: default
spec:
  containers:
  - image: nginx
    imagePullPolicy: Always
    name: nginx
    resources:
      limits:
        memory: 512Mi
      requests:
        memory: 512Mi
  priorityClassName: medium
  restartPolicy: Always
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: pod2
  namespace: default
spec:
  containers:
  - image: nginx
    imagePullPolicy: Always
    name: nginx
    resources:
      limits:
        memory: 512Mi
      requests:
        memory: 512Mi
  priorityClassName: medium
  restartPolicy: Always
EOF

touch /tmp/finished
