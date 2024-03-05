# How to use a ConfigMap

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: animal
  namespace: default
data:
  ANIMALS: dogs
EOF

touch /tmp/finished
