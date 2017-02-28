FROM wordpress:latest
MAINTAINER Simplify Commerce

ENV WOOCOMMERCE_VERSION 2.6.14

COPY . /usr/src/wordpress/wp-content/plugins/simplifycommerce/

RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip wget \
    && wget https://downloads.wordpress.org/plugin/woocommerce.$WOOCOMMERCE_VERSION.zip -O /tmp/temp.zip \
    && cd /usr/src/wordpress/wp-content/plugins \
    && unzip /tmp/temp.zip \
    && cd /usr/src/wordpress/wp-content/plugins \
    && rm /tmp/temp.zip \
    && rm -rf /var/lib/apt/lists/*

RUN cd /usr/src/wordpress/wp-content/plugins/ \
    && chown -R www-data:www-data woocommerce/ \
    && chown -R www-data:www-data simplifycommerce/

# Download WordPress CLI
RUN curl -L "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar" > /usr/bin/wp && \
    chmod +x /usr/bin/wp

VOLUME ["/var/www/html"]