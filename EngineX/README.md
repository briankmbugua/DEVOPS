# NGINX
nginx has one master process and several worker processes.Worker processes do actual processing of requests.
The number of worker process is defined in the configuration file or automatically adjusted to the number of avialable cpus.
# Starting, Stopping, Reloading Configuration
Once the nginx is started, it can be controlled by invoking the executable with the -s parameter.
```bash
nginx -s signal
```
Where signal is one of the following
- stop - fast shutdown
- quit - graceful shutdown
- reload - reloading the configuration file
- reopen - reopening the log files
## example
to stop nginx processes with waiting for the worker process to finish serving current requests
```bash
nginx -s quit
```
changes made to the configuration file will not be applied untill the command to reload configuration is sent to nginx or it is restarted.
```bash
nginx -s reload
```
A singnal may also be sent using unix tools like kill
example master process ID is 1628 to send the quit signal resulting in nginx'x graceful shutdown
```bash
kill -s QUIT 1628
```
To get a list of running processes use
```bash
ps -ax | grep nginx
```

# configuration file structure
nginx consits of modules which are controlled by the directives specified in the configuration file.
## Directives
- Simple directives - A simple directive consits of name and parameters separated by spaces and ends with a semicolon (;)
- Block directives - Has the same structure as a simple directive but instead of the semicolon it ends with a set of additional instructions sorrounded by braces({ and }), If a block directive can have other directives inside braces, it is called a context(events, http, server, and location)
## Main context
Directives placed in the configuration file outside of any contexts are considered to be in the main context
The events and http directives reside in the main context.server in http, and location in server.
# events
The events section is a required section in nginx configuration files
# Block directives
- events {} - The events context is used for setting global configuration regarding how NGINX is going to handle requests on a general level.There can be only one events context in a valid configuration file.
- http{} - http context is used for defining configurations regarding how the server is going to handle HTTP and HTTPS requests, specifically.There can be only one http context in a valid configuration file.- server {} - The sever context is nested inside the http context andused for configuring specific virtual servers within a single host.There can be multiple server contexts in a valid configuration file nesed inside the http context.Each server context is considered a virtual host.
- main - The main context is the configuration file itself.Anything written outside of events,http and server contexts is on the main context.
There can be multiple server contexts within a configuration file.
# listen directive
The listen directive is one of the ways to identify the correct server context within a configuration file.
# Example
```bash
http {
     
     server {
            
	    listen 80;
	    server_name nginx-handbook.test;

	    return 200 "Hello from port 80!\n";
     }

     server {
             listen 8080;
	     server_name nginx-handbook.test;
	     return 200 "Hello from port 8080!\n";
     }
}

```
If you send a request to http://nginx-handbook.test:80 then you'll receive "Hello from port 80!".And if you send a request to http://nginx-handbook.test:8080, you'll receive "Hello from port 8080!"
# server_name directive
Example
http {
     server {

     listen 80;
     server_name library.test;

     return 200 "Your local library!\n"
     }

     server {
      listen 80;
      server_name librarian.library.test;

      return 200 "Welcome dear librarian!\n"
     }
}

Here you're running two separate applications under different server names in the same server.
```bash
curl http://library.test
# Your local library
curl http://librarian.library.test
# Welcome dear librarian!
```
To make the above demo work, update the hosts file to include these two domain names as well:
# return directive
The return directive is responsible for returning a valid response to the user.This directive takes two parameters:The status code and the string message to be returned.

# How to Serve Static Content

You have to store static content somewhere in order to serve it.















