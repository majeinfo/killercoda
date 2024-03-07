# Bad netpol !

cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
spec:
  replicas: 1
  selector:
    matchLabels:
      tier: back
      role: redis
  minReadySeconds: 10
  template:
    metadata:
      labels:
        app: redis
        role: redis
        tier: back
        version: latest
    spec:
      containers:
        - image: majetraining/redis:latest
          imagePullPolicy: Always
          name: redis
          ports:
            - containerPort: 6379
      restartPolicy: Always
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  labels:
    role: redis
    tier: back
  name: redis
spec:
  selector:
    app: redis
  ports:
    - port: 6379
      targetPort: 6379
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  labels:
    role: redis
    tier: back
  name: redis
spec:
  selector:
    app: redis
  ports:
    - port: 6379
      targetPort: 6379
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: vote
  labels:
    app: python
    role: vote
    version: v1
  annotations:
    linkerd.io/inject: enabled
spec:
  containers:
    - name: app
      image: majetraining/vote:v1
      ports:
        - containerPort: 80
          protocol: TCP
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: vote
  labels:
    role: vote
spec:
  type: ClusterIP
  selector:
    role: vote
  ports:
    - name: pythonapp
      port: 80
      targetPort: 80
EOF

cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny
  namespace: default
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
EOF

cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-vote
  namespace: default
spec:
  podSelector:
    matchLabels:
      role: vote
  policyTypes:
    - Ingress
  ingress:
    - {}
EOF

touch /tmp/finished
