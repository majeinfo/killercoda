# Wrong base64 secret !

kubectl create secret generic mysql-secret --from-literal=ROOT_PASSWORD=fix-me

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: mysqlsrv
  namespace: default
  labels:
    app: backend
spec:
  containers:
    - image: mysql:5.7
      imagePullPolicy: Always
      name: mysqlsrv
      env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: ROOT_PASSWORD
      resources:
        limits:
          memory: 768Mi
        requests:
          memory: 768Mi
  restartPolicy: Always
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: mysqlsrv
  namespace: default
spec:
  type: ClusterIP
  selector:
    app: backend
  ports:
    - name: mysql
      port: 3306
      targetPort: 3306
EOF

touch /tmp/finished
