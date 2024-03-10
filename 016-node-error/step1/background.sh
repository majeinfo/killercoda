# Node in cordoned !

cd /tmp
dd if=/dev/zero of=big1 bs=1024 count=1000000
for IND in {2..11}; do
	cp big1 big${IND}
done

sleep 5

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: worker
  namespace: default
spec:
  containers:
  - image: busybox
    imagePullPolicy: IfNotPresent
    name: worker
    command:
      - /bin/sh
      - -c
      - dd if=/dev/zero of=/tmp/myfile bs=1024 count=1000000
      - "&&"
      - sleep 3600
  restartPolicy: Always
EOF

touch /tmp/finished
