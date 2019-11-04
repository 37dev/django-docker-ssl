FROM nginx
LABEL maintainer="Elliot Saba <staticfloat@gmail.com>, Valder Gallo <valergallo@gmail.com>, Bruno Zell <bruno.zzell@gmail.com>"


# Do this apt/pip stuff all in one RUN command to avoid creating large
# intermediate layers on non-squashable docker installs
RUN apt update && \
    apt install -y python python-dev libffi6 libffi-dev libssl-dev curl build-essential gettext-base && \
    curl -L 'https://bootstrap.pypa.io/get-pip.py' | python && \
    pip install -U cffi certbot && \
    apt remove --purge -y python-dev build-essential libffi-dev libssl-dev curl && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy in scripts for certbot
COPY ./config/nginx/scripts/ /scripts
RUN chmod +x /scripts/*.sh

# Add /scripts/startup directory to source more startup scripts
RUN mkdir -p /scripts/startup

# Copy in default nginx configuration (which just forwards ACME requests to
# certbot, or redirects to HTTPS, but has no HTTPS configurations by default).
RUN rm -f /etc/nginx/conf.d/*

COPY ./config/nginx/nginx.template /etc/nginx/conf.d/nginx.template
COPY ./config/nginx/certbot.conf /etc/nginx/conf.d/certbot.conf

COPY ./config/nginx/options-ssl-nginx.conf /etc/letsencrypt/options-ssl-nginx.conf
COPY ./config/nginx/ssl-dhparams.pem /etc/letsencrypt/ssl-dhparams.pem

ENTRYPOINT []
CMD ["/bin/bash", "-c", "envsubst '$$NGINX_HOST'< /etc/nginx/conf.d/nginx.template > /etc/nginx/conf.d/default.conf && /scripts/entrypoint.sh"]