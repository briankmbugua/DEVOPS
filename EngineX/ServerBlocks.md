# Example comfiguration
We are going to set up two domains with our Nginx server.briankinyanjui.com and software.com

# Setting Up New Document Root Directories
By default, nginx has one server block enabled.It is configured to serve documents out of a directory at /var/www/html.

- Create a directory structure within /var/www.The actual html content will be placed in a html directory within these site-specific directories.
```bash
sudo mkdir -p /var/www/briankinyanjui.com/html
sudo mkdir -p /var/www/software.com/html
```
- Reassign ownership of the web directories to our normal user account.This will let us write to them without using sudo,
- use the $USER env variable to assing ownership make sure you are not singed in as root.Change ownership of the directory recursively for all files and directories within the specified direcotry and subdirectories
```bash
sudo chwon -R $USER:$USER /var/www/briankinyanjui.com/html
```
# Creating sample pages for each direcory
Creat an index.html in both domains briankinyanjui.com and software.com
# Creating Server Block Files for Each Domain
Creat server block config file by copying over the default file or creating the config file and adding all the configurations yourself
The config file for each server block should be stored in the directory /etc/nginx/site-available/briankinyanjui.com.Here briankinyanjui.com is the config file for the briankinyanjui.com server block.
```bash
# This is how the default config looks like, remove default server from other config files
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html; #this is the root directory of where your html files will be stored
    index index.html index.html index.nginx-debian.html; #default file to serve if no filename is specified in the request.

    server_name_; #here you specify the domain name or the ip address that the server will responed to

    location / {
        try_files $uri $uri/ =404; #this directive tell Nginx to first try to serve the requested file and if that fails to return 404 error
    }

}
```
Only one of our server blocks on the server can have the default_server option enabled.This specifies which block should serve a request if the server_name requested does not match any of the available server blocks

# Enabaling the server blocks
To enable server blocks we create symbolic links from the server block files to the sites-enabled directory
# site-enabled directory
The site enabled directory is used to enable and disable server configurations.When you create a new server config in the site-available directory it is not automatically enabled.To enable configuration you need to create a symbolic link to it the sites-enabled directory
```bash
sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/test.com /etc/nginx/sites-enabled/
```
in the default config file uncomment the server_names_hash_bucket_size directive this is to prevent possible hash backet memory problem that can arise from adding additional server names.

Use nginx -t to test that your config file is okay
