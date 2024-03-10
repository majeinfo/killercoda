# Unprivileged user can access PKI !

useradd -m -s /bin/bash user1

# Create certificate for user1
cd /home/user1
openssl genrsa -out user1.key 4096
cat <<EOF >csr.cnf
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn

[ dn ]
CN = user1
O = dev

[ v3_ext ]
authorityKeyIdentifier=keyid,issuer:always
basicConstraints=CA:FALSE
keyUsage=keyEncipherment,dataEncipherment
extendedKeyUsage=serverAuth,clientAuth
EOF

openssl req -config ./csr.cnf -new -key user1.key  -nodes -out user1.csr

cat <<EOF >csr.yml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: user1_csr
spec:
  signerName: kubernetes.io/kube-apiserver-client
  groups:
  - system:authenticated
  request: |
EOF

cat user1.csr | sed 's/^/    /' >>csr.yml

cat <<EOF >>csr.yml
  usages:
  - digital signature
  - key encipherment
  #- server auth
  - client auth
EOF

kubectl certificate approve user1_csr
kubectl get csr user1_csr -o jsonpath='{.status.certificate}' | base64 --decode > user1.crt
kubectl create ns dev

cat <<EOF | kubectl apply -f -
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: dev
  name: dev
rules:
- apiGroups: [""]
  resources: ["pods", "services"]
  verbs: ["create", "get", "update", "list", "delete"]
- apiGroups: ["apps"]
  resources: ["deployments"]
  verbs: ["create", "get", "update", "list", "delete"]
EOF

cat <<EOF | kubectl apply -f -
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: dev
  namespace: dev
subjects:
- kind: Groupe
  name: dev
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: dev
  apiGroup: rbac.authorization.k8s.io
EOF

mkdir .kube
export CLUSTER_CA=$(kubectl config view --raw -o json | jq -r '.clusters[] | select(.name == "'kubernetes'") | .cluster."certificate-authority-data"')
export CLIENT_CERTIFICATE_DATA=$(kubectl get csr user1_csr -o jsonpath='{.status.certificate}')

cat <<EOF > .kube/config
apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority-data: ${CLUSTER_CA}
    server: https://172.30.1.2:6443
  name: kubernetes
users:
- name: user1
  user:
    client-certificate-data: ${CLIENT_CERTIFICATE_DATA}
    client-key-data: ${CLIENT_KEY_DATA}
contexts:
- context:
    cluster: kubernetes
    user: user1
  name: kubernetes
current-context: kubernetes
EOF

kubectl config set-credentials user1 --client-certificate=user1.crt --client-key=user1.key --embed-certs=true --kubeconfig=/home/user1/.kube/config
chown -R user1:user1 .kube *

touch /tmp/finished
