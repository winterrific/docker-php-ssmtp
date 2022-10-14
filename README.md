# Php8.1 + Apache + SSMTP

** FORK of [harobed/docker-php-ssmtp](https://github.com/harobed/docker-php-ssmtp) ** with php8.1 and using additional traefik container for ssl etc. Additional slight changes of ssmtp config for setting domain overwrite and root mail address.

This image add [ssmtp](https://wiki.archlinux.org/index.php/SSMTP) service to official
[Docker Php8 Apache image](https://github.com/docker-library/php/).

With *ssmtp** you can use buildin [mail](http://php.net/manual/en/function.mail.php) Php function
to send mails via smtp server configured by `SSMTP_*` environment variables.

This image enable also [Apache Rewrite mod](http://httpd.apache.org/docs/current/mod/mod_rewrite.html), *RewriteEngine* can be used in [.htaccess](www/.htaccess).

`docker-compose.yml` example to use `apache` service togehter with `traefik`:

```
version: '3'
services:
  apache:
    build: .
    image: winterrific/php-ssmtp:8.1-apache
    volumes:
      - ./www/:/var/www/html/
    expose:
      - 80
    labels:
      - traefik.http.routers.apache-php-ssmtp.rule=Host(`example.com`)
      - traefik.http.routers.apache-php-ssmtp.tls=true
      - traefik.http.routers.apache-php-ssmtp.tls.certresolver=le
      - traefik.http.routers.apache-php-ssmtp.entrypoints=websecure
      - traefik.docker.network=traefik

networks:
  traefik:
    external: true
```

See [Dockerfile](Dockerfile) to see environment variable default values.


## How to test

```
$ git clone https://github.com/harobed/docker-php-ssmtp.git
$ cd docker-php-ssmtp
$ docker-compose build
$ docker-compose up -d
$ echo "Browse to http://`docker-compose port apache 80`"
```
