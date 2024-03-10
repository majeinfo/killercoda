This time you are not the "root" user but your name is "user1".
You cannot access the "/etc/kubernetes/pki/ca.key" file located on the controlplane node (check it !).
But you have been given privileges to run Deployments in a specific namespace
(you must find which on).

Can you use this privilege to access the K8s private key ?
As a proof, make a copy of this key on the controlplane node, with the name "/tmp/ca.key"
and make it owned by "user1"...

Note: you **must not** try to change your privileges
