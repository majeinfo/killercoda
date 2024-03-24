# Wrong .kube/config file !

sed 's/172\.30\.2\.1:6443/172.31.1.2:443/' -i /root/.kube/config

touch /tmp/finished
