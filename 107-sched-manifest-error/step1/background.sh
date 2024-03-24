# Wrong kube-scheduler manifest !

sed 's/--bind-address/--bind-adress/' -i /etc/kubernetes/manifests/kube-scheduler.yaml

while pidof kube-scheduler; do
	sleep 3
done

kubectl run nginx --image=nginx

touch /tmp/finished
