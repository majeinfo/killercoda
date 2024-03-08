A web application has been deployed by the "frontend" Deployment.
It just displays a message specified by the "MSG" environment variable.

The value of "MSG" is read from the "frontend-config" ConfigMap.

But if the value in the ConfigMap changes, the web application won't be restarted and
won't use the new value !

As a fix, we installed a Custom Controller which is deployed by the "cuscon" Deployment.
This Custom Controller connects to the apiserver and watches for the changes made on ConfigMaps.
To find the Pod that must be restarted, the Controller must find an annotation in the ConfigMap.
This annotation looks like :

majetraining/podDeleteMatch: "label=value"

Then the Custom Controller will kill the Pods labelled "label=value".
Since the Pod are normally controlled by a Deployment, they will be restarted !

How to test ?

$ curl <frontend_Pod_IP>

should display "Welcome to Kubernetes"

Then, change the value of the "frontend-config" ConfigMap.
Send another request to the app :

$ curl <frontend_Pod_IP>

...you should see the new value !

Can you make it work ?

