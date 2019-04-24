---
title: "Deploying Django Channels Application"
date: 2019-04-24
draft: false
description: "Some simple example configs to deploy a Django Channels Application"
---

## Django
For quite some time python has been one of my favourite programming language. Although its not the best choice for all use cases, the right tool for the right job after all, it has a very nice flow to it when programming. Things are easily done, the documentation quite good and there is a lot of help available through google.

One of the best examples for the excellent ecosphere of libraries that can be used with python is [Django](https://www.djangoproject.com/), a framework to create web application. With [my company](https://kolibrisolutions.nl/) I use this exclusively. We also use the Django extension [Channels](https://channels.readthedocs.io/en/latest/), which extens django with support for things like websockets, as well as preparing it for a better codebase in the future. Channels will eventually be merged into the core Django.

I will not get into why Django and Channels is so awesome in this post. But I do get questions about the best way to deploy it, and have to do this often myself. Therefor I have made this short post to explain this.

## Deployement Structure
The standard way to set it up is by running the python behind a reverse proxy and use redis for the channels backend routing. This way each component can do what it does best. The reverse proxy in the form of a webserver can handle things like http2, ssl and other standard web things. It can also directly server the static files. The python process will then handle all application things. Lastly a fast key value store like redis can synchronize the backend as well as provide caching support. Redis needs almost zero configuration, especially if yo urun seperate systems on seperate machines, like most of my own use cases.

For the reverse proxy I use Nginx and for the python process daphne. Instead of Nginx, you can also use apache. For the python process django channels provides daphne with a lot of documentation, but you can use any ASGI compatible service. I use dahpne because of the support on it and wrap it into a systemd service.

Obviously you also need a database. I usually use postgresql. Database setup is pretty standard so I'm gonna leave it outside of this post.

In the example config below ```<projectname>``` is assumed to be the name of the folder in which the routing, settings etc files are stored. This is automatically generated by django-admin upon creation of a django project.

## Django Application Setup
Make sure your django application follows the direction of the django channels deployement page found [here](https://channels.readthedocs.io/en/latest/deploying.html). Most importantly you need a ```myproject.asgi``` file as well as setup ```CHANNELS_LAYERS``` correctly.

If you setup redis on default settings (on localhost) this will suffice:
```
# channels, a new and better way to run Django including websockets.
ASGI_APPLICATION = '<projectname>.routing.application'
CHANNEL_LAYERS = {
    'default': {
        'BACKEND': 'channels_redis.core.RedisChannelLayer',
        'CONFIG': {
            "hosts": [('127.0.0.1', 6379)],
        },
    },
}
```

For the asgi setup the follow minimal example is enough for most applications:
```
import os

import django
from channels.routing import get_default_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "<projectname>.settings")
django.setup()
application = get_default_application()

```
For setting up routing etc consult the django channels docs, that is out of the scope of this short deployement guide.

## Daphne Setup
To serve the above django application I use daphne. This is quite easy, simply go to the folder of the application and execute the following:
```
daphne -u /tmp/daphne.sock <projectname>.asgi:application
```
This will start daphne in non daemon mode and open a local sock opbject for requests. The reason I do it in non daemon mode is because I can then easily wrap it into a service file. All messages from daphne are printed to stdout and can be easily read then from the systemd journal.

A minimal systemd service will be something like this:
```
[Unit]
Description=daphne service to run django application
After=network.target
After=postgresql.service
After=nginx.service

[Service]
Type=simple
RuntimeDirectory=daphne
PIDFile=/run/daphne/pid
User=django
Group=django
WorkingDirectory=<application root>
ExecStart=/usr/bin/daphne -u /tmp/daphne.sock <projectname>.asgi:application
ExecStop=/bin/kill -s TERM $MAINPID
[Install]
WantedBy=multi-user.target
```

If you installed everything into a python virtual environment (recommendable!) then simply replace ```/usr/bin/daphne``` by the location of daphne inside of the virtual environment. It will automatically pick this up and use the virtual environment.

## Reverse Proxy setup
For the reverse proxy setup I use nginx. For nginx it is recomendable to use a setup in which every site has a sub config in sites-enabled folder, this is however up to you. I will share here an example config for the server block for the django application below.
```
upstream app_server {
    server unix:/tmp/daphne.sock fail_timeout=0;
}

server {
    listen 443 ssl http2;
    server_name <hostname>;
    
    client_max_body_size 20M; # this is optionally, I usually put it very big in nginx and do proper size checks in the application
    
    location /static/ {
        sendfile on;
        location ~* \.(?:ico|css|js|gif|jpe?g|png|svg|woff|bmp)$ {
            expires 7d;
        }
        alias <application static folder>;
    }
    
    
    location / {
        proxy_pass http://app_server;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $server_name;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header X-Forwarded-Proto "https";
        proxy_set_header Connection "upgrade";
        add_header Referrer-Policy "no-referrer-when-downgrade";
    }
}
```

## Starting Setup
Simply start redis nginx and the database in the default way, for example with systemd. Daphne can be started with the default command for a custom service:
```
systemctl start daphne
```
Dont forget to enable all services that are necesarry on your server to auto start on boot, for example with
```
systemctl enable daphne
```

And thats it! Have fun with you live production ready Django Channels Application!