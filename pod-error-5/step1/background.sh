# Wrong web page !

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
    volumeMounts:
      - name: document_root
        mountPath: /tmp
  restartPolicy: Always
  volumes:
    - name: document_root
      hostPath:
        path: /usr/share/nginx/html
        type: Directory
EOF

touch /tmp/finished
