A voting application is reachable via a simple Pod.
But there are two running versions.

You can test the different versions with this command :

$ curl <Pod_IP>

You should see different results according to the version.

For each version (each Pod), a CluterIP service has been configured :
- "vote1" Service should route packets to "vote1" Pod
- "vote2" Service should route packets to "vote2" Pod
 
A nginx Ingress Controller has been installed and the "ingress.yml" file
describes 2 Ingress Rules that should route the requests to "vote1" or "vote2" Service
according to the "Host" HTTP Header.

The following commands should work (but won't !) :

$ curl -H vote1 <IP_of_vote1_service>
$ curl -H vote2 <IP_of_vote2_service>

Can you do it ?

