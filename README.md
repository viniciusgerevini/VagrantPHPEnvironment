Vagrant PHP Environment
=====================

My Vagrant PHP environment provisioned with Puppet (Ubuntu 14.04, NGINX, MySQL and PHP-FPM).

##Dependencies

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)

##Instructions
- Clone this repository in your folder
- Change $mysql_password in puppet/manifests/init.pp
- Run:
```sh
$ vagrant up
```

##Tips

###How to run on port: 80
For security reasons you can't forward small port numbers (less than 1024).
But if you need/want to transparently access your server you can redirect ports on you firewall.
Eg: 80 to 8080.

On linux you can do this:

```sh
$ iptables -t nat -A OUTPUT -p tcp -d 127.0.1.1 --dport 80 -j  REDIRECT --to-port 8080
```
After this you can browse your webserver through http://localhost.


###How to use virtual hosts
The files in nginx_sites folder will be copied to (Guest) /etc/nginx/sites-enabled (Nginx default virtual host folder).
It will happen only when the guest machine is provisioned.

To access these virtual hosts through your host browsers you will need to put the entries in your 'hosts' file (Host machine).

Eg: To transparently access 'my-site.local' virtual host:

File:
- On linux: '/etc/hosts'
- On Windows: 'C:\windows\hosts'

```sh
127.0.1.1       my-site.local
```

After that you can access this address through your host's browser: http://my-site.local

##To do

- Ruby / Compass
- PhpMyAdmin
