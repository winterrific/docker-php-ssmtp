#!/bin/bash
set -e

exec /usr/local/bin/gomplate -f /ssmtp.conf.tmpl -o /etc/ssmtp/ssmtp.conf

exec apache2-foreground
