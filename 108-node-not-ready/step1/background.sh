# Wrong kubelet config !

sed 's/6443/443/' -i /etc/kubernetes/kubelet.conf
systemctl restart kubelet

STATE=$(kubectl get no controlplane -o jsonpath='{.spec.taints[0].key}')
while [ "$STATE" != "node.kubernetes.io/unreachable" ]; do
	sleep 3
	STATE=$(kubectl get no controlplane -o jsonpath='{.spec.taints[0].key}')
done

kubectl run nginx --image=nginx

touch /tmp/finished
