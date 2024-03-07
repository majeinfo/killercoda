A voting application is made up of two Pods :
- one Pod is used to display the web interface and can be accessed through the service named "vote"
- one Pod implements a Redis database that can be reached through the service named "redis"

The following command tests the web access:

$ curl <vote_service_IP>

To check the connectivity between the voting Pod and the Redis database, you may execute the following command :

$ curl -XPOST <vote_service_IP> -d "vote=a"

You should get a response immediatly... but you won't ! Why !

Can you do it ?

Note: you **must not remove or change** any existing object
