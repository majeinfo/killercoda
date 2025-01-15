Your challenge is very simple :
when you run this command :

`$ kubectl create deploy nginx --image=nginx`

you should see that no Pods are created ! Why ?

Once you found the cause of the error, you have to remove the mechanism that blocks your request and check that the Pod is now created.

