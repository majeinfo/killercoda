# Wrong initContainer command !

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: web
  namespace: default
spec:
  initContainers:
    - name: init
      image: busybox
      command:
        - /bin/sh
        - -c
        - "This is all about cats > /mnt/index.html"
      volumeMounts:
        - name: shared-pages
          mountPath: /mnt
  containers:
    - image: nginx:1.8
      imagePullPolicy: IfNotPresent
      name: web
      volumeMounts:
        - name: shared-pages
          mountPath: /usr/share/nginx/html/
  volumes:
    - name: shared-pages
      emptyDir: {}
EOF

touch /tmp/finished
