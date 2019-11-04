# Credits
**ruddra:** [github.com/ruddra/docker-django](https://github.com/ruddra/docker-django)

**staticfloat:** [github.com/staticfloat/docker-nginx-certbot](https://github.com/staticfloat/docker-nginx-certbot)

This project was based on these two projects above. Special thanks for ruddra and staticfloat!

# Goal:
This project main goal is to provide a way to deploy django applications by using docker along with
nginx, gunicorn and letsencrypt. Celery is also included (using redis) but you don't have to use it.

# Development
You can clone this repo and start your project from scratch using this project. All your django apps 
(with the command: python manage.py startapp) go in the 'src' folder (if you are using pycharm: -
right click in src folder > mark directory as > sources root). Make sure to register your apps in src > core > settings

In development mode, you **will not** be able to run nginx, unless you have all your modem ports forwarded.

To test your apps, you will have to use the default django development server (python manage.py runserver).

Don't forget to install requirements while testing.

# Configuration
Configuration files are inside .envs folder. By default, dev.env files are loaded for each project.
Config options are self explanatory, but there are some important things to mention:
* DB config in django envs folder must be the same as it is in the postgres config.
* Do not choose the username 'postgres' for the postgres config.
* DJANGO_ALLOWED_HOSTS should contain '.example.com' to accept all hosts from nginx.
* EMAIL config must be set only if you will be using `send_email` in your project.
* SENTRY_DSN is optional and will only track errors in django container
* **important:** NGINX_HOST must just include your base domain. If you have wwww.example.com
  it must be set as example.com . This is because when letsencrypt generates the certificates, it will
  use your base domain to generate a certificate valid for your www domain and non www domain.
* If you want to create more subdomains, you will have to change the file in config>nginx>default.template
  and pass the correct env variables plus adding the correct directives. Also, add your subdomain to the certbot command.
* IS_STAGING must be set to 1 if you want to test your project in production to avoid rate limiting from letsencrypt.

# Production
Once you have your project done, it's time to go into production mode!

1 - Send your project to your server (Debian servers are preferred, for now), without virtualenv files.

2 - Once it is there, get inside your project and install deps for docker with `./debian_install.sh`

3 - Reboot your machine with `sudo reboot now`

4 - Now, inside your project folder, build your containers by typing `make build`

5 - Once it is finished, put it online with `make up`


It is a good practice, on the first run, to check for any errors.. To do so, start your project with `make up-non-daemon`

If you see no errors, it is probably safe to start it normally with `make up`
