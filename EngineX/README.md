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
In the root of the server, there is a directory called /srv in thre.This /srv directory is meant to contain site-specific data whic is served by this system.
Copy all the files you want to serve in this directory
# Serving-Static-Content
```bash
events {

}

http {

    server {

        listen 80;
        server_name nginx-handbook.test;

        root /srv/nginx-handbook-projects/static-demo;
    }

}
```
# root directive
Here the return directive has been by a root directive.This directive is used for declaring the root directory for a site.

By writting root /srv/directory/for/your/site. You are telling NGINX to look for files to serve inside the /srv/directory if any request comes to this server.Since NGINX is a web server, it is smart enough to serve the index.html file by default.
But after serving the html file enginex did not serve the CSS file

# Stativ File Type Handling in NGINX
Enginex doesn't know how to handle file types

add types context inside the http context.This type context is used for configuring file types.

```bash
...
http{
types {
text/html html;
text/css css;
}
}
```
By writting `text/html html` in this context you're telling NGINX to parse any file as `text/html` that ends with the html extension.
By introducing the types context in the configuration, NGINX only parses the files configured by you.
# How to Include Partial Config Files
Mapping file types within the types context may work for small projects, for bigger projects it is cumbersome and error-prone
In /etc/nginx directory there is a file named mime.types.
When you look inside the mime.types file you will see a long list of file types and their extensions.
To use this file
```bash
...
http{
include /etc/nginx/mime.types;

server {
...rest of config file
}
}
```
## include directive
The old types context has now been replaced with a new include directive.This directive allows you to include content from other configuration files.You will use include to modularize your virtual server configurations.

# Dynamic Routing in NGINX
## Location Matches
```bash
events {}
http {
     
     server {

          listen 80;
	  server_name nginx-handbook.test;

	  location   /agatha {
	      
	        return 200 "Miss Marple.\nHercule Poirot. \n";
	  }
     }
}
```
Above we've replaces the root directive with a new location context.
This context is usually nested inside the server blocks.There can be multiple `location` contexts within a server context.
If you send a request to `http://nginx-handbook.test/agatha`
```bash
curl -i http://nginx-handbook.test/agatha
#This is what is returned
HTTP/1.1 200 OK
Server: nginx/1.18.0 (Ubuntu)
Date: Mon, 14 Aug 2023 10:19:23 GMT
Content-Type: text/plain
Content-Length: 29
Connection: keep-alive

Miss marple.
Hercule Poirot.
```
Now if you send a request to `http://nginx-handbook.test/agatha-christie` you'll get the same response
```bash
curl -i http://nginx-handbook.test/agatha
HTTP/1.1 200 OK
Server: nginx/1.18.0 (Ubuntu)
Date: Mon, 14 Aug 2023 10:19:23 GMT
Content-Type: text/plain
Content-Length: 29
Connection: keep-alive

Miss marple.
Hercule Poirot.
```
This happens because, by writting `location /agatha` you're telling NGINX to match any URI starting with "agatha".This kind of match is called a `prefix match`

To perform an `excat match`, do the following
```bash
events {}
http{
    
    server {

          listen 80;
	  server_name nginx-handbook.test;


	  location = /agatha {
	        return 200 "Miss Marple.\nHercule Poirot.\n";
	  }
    }
}
```

Adding the = sign before the location URI will instruct NGINX to respond only if the URL matches exactly.If a request is sent to anything but /agatha, you'll get a 404 response.
```bash
curl -I http://nginx-handbook.test/agatha-christie

HTTP/1.1 404 Not Found
Server: nginx/1.18.0 (Ubuntu)
Date: Wed, 21 Apr 2021 16:14:29 GMT
Content-Type: text/html
Content-Length: 162
Connection: keep-alive

curl -I http://nginx-handbook.test/agatha

HTTP/1.1 200 OK
Server: nginx/1.18.0 (Ubuntu)
Date: Wed, 21 Apr 2021 16:15:04 GMT
Content-Type: text/plain
Content-Length: 29
Connection: keep-alive
```
Another kind of match in NGINX is the `regex match`.Using this match you can check location URLs against complex regular expressions.

```bash
events {}
http{
     
     server {


     listen 80;
     server_name nginx-handbook.test;

     location ~ /agatha[0-9] {

     return 200 "Miss marple.\nHercule poirot.\n";
     }
     }
}
```
By replacing the previous = sign with a ~ sign, you're telling NGINX to perform a regular expression match.Setting the location to `~ /agatha[0-9]` means NGINX will only respond if there is a number after the word "agatha":
```bash
~  curl -I http://nginx-handbook.test/agatha 
HTTP/1.1 404 Not Found
Server: nginx/1.18.0 (Ubuntu)
Date: Mon, 14 Aug 2023 23:47:13 GMT
Content-Type: text/html
`Content-Length: 162
Connection: keep-alive

~  curl -I http://nginx-handbook.test/agatha8
HTTP/1.1 200 OK
Server: nginx/1.18.0 (Ubuntu)
Date: Mon, 14 Aug 2023 23:47:18 GMT
Content-Type: text/plain
Content-Length: 29
Connection: keep-alive
```
A `regext match` is by default case sensitive,To turn it into case insensitive, add `*` after the `~` sign.
```bash
# inside server context
location ~* /agatha[0-9]
```

NGINX assings priority values to these matches, and a rgex match has more priority than a prefix match.
There is also preferential prefix match.

# List of all the matches in descending order of priority is as follows
- Exact   =
- Preferential Prefix   ^~
- REGEX    ~or~*
- Prefix   None

# Variables in NGINX
The `set` directive can be used to declare new variables anywhere within the configuration file
```bash
set $<variable_name> <variable_value>;
set name "Farham"
set age 25
set is_working true
```
Variables can be of three types
- String
- Integer
- Boolean

Apart from the varibales you declared, there are embedded variables within NGINX modules.
For a variable to be accessible in the configuration, NGINX has to be built with the module embedding the variable.

# Redirects and Rewrites
## config file for a redirect
```bash
events {}
http {
      
      include /etc/nginx/mimi.types;

      server {
             
	     listen 80;
	     server_name nginx-handbook.test;

	     root /srv/nginx-handbook-projects/static-demo;


	     location = /index_page {
	                return 307 /index.html;
	     }
	     location = /about_page {
	                return 307 /about.html;
	     }
      }
}
```
Now if you send a request to `http://nginx-handbook.test/about_page`, you'll be redirected to `http://nginx-handbook.test/about.html`.
If you visit `http://nginx-handbook.test/about_page` you will see that the URL will automatically change to `http://nginx-handbook.test/about.html`.
# rewrite directive
A rewrite directive works a little differently.It changes the URI internally without letting the user know.

## Example
```bash
events {}
http {
      
      include /etc/nginx/mime.types;

      server {
             
	     listen 80;

	     server_name nginx-handbook.test;

	     root /srv/nginx-handbook-projects/static-demo;

	     rewrite /index_page /index.html;

	     rewrite /about_page /about.html;
      }
}
```
Now if you send a request to `http://nginx-handbook.test/about_page` URI, you'll get a 200 response code and the HTML code for the about.html file in the response
And if you visit the URI using a browser, you'll see the about.html page while the URL remains unchanged.Apart from the way the URI is handled, there is another difference between redirect and rewrite.When a rewrite happens, the server context gets re-avaluated by NGINX.So, a rewrite is more expensive operation than a redirect.



# try_files directive

Instead of responding with a single file, the try_files directive lets youcheck for the existence of multiple files.

```bash
events{}
http{
     
     include /etc/nginx/mime.types;

     server {
            
	    listen 80;
	    server_name nginx-handbook.test;

	    root /srv/nginx-handbook-projects/static-demo;

	    try_files /the-nginx-handbook.jpg  /not_found;
     }
}
```









