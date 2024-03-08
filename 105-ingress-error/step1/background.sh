# Bad Ingress and Service !

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.4/deploy/static/provider/cloud/deploy.yaml

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: vote1
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
  name: vote1
  labels:
    role: vote
spec:
  type: ClusterIP
  selector:
    role: vote
    version: v1
  ports:
    - name: pythonapp
      port: 80
      targetPort: 80
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: vote2
  labels:
    app: python
    role: vote
    version: v2
  annotations:
    linkerd.io/inject: enabled
spec:
  containers:
    - name: app
      image: majetraining/vote:v2
      ports:
        - containerPort: 80
          protocol: TCP
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: vote2
  labels:
    role: vote
spec:
  type: ClusterIP
  selector:
    role: vote
    version: v1
  ports:
    - name: pythonapp
      port: 80
      targetPort: 80
EOF

touch /tmp/finished
