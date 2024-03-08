# Bad Permission !

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: "frontend-config"
  annotations:
    majetraining/podDeleteMatch: "cm=restart"
data:
  config.cfg:
    MSG="Welcome to Kubernetes"
EOF

cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  labels:
    app: frontend
spec:
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: app
        image: majetraining/k8s-cuscon-flask-app
        volumeMounts:
        - name: config-vol
          mountPath: /config
      volumes:
      - name: config-vol
        configMap:
          name: frontend-config
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: configmap-watcher
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: configmap-watcher-runner
rules:
  - apiGroups: [""]
    resources: ["configmaps"]
    verbs: ["get", "list" ]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: run-configmap-watcher
subjects:
  - kind: ServiceAccount
    name: configmap-watcher
    namespace: default
roleRef:
  kind: ClusterRole
  name: configmap-watcher-runner
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cuscon
  labels:
    app: cuscon
spec:
  selector:
    matchLabels:
      app: cuscon
  template:
    metadata:
      labels:
        app: cuscon
    spec:
      serviceAccount: configmap-watcher
      containers:
      - name: proxycontainer
        image: lachlanevenson/k8s-kubectl
        command: ["kubectl","proxy","--port=8001"]
      - name: app
        image: majetraining/k8s-cuscon-controller
        env:
          - name: res_namespace
            valueFrom:
              fieldRef:
                fieldPath: metadata.namespace
EOF

touch /tmp/finished
