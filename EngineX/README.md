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