#!/bin/sh 

# This is as bare-bones as you can get.
# Individual service failures are not caught.
# Terminate the container to recover from such issues.
# User-provided configs can cause container failures. Make sure your configs are solid.
# To do: make this robust, maybe with a supervisor.

# Start MySQL/MariaDB
nohup /usr/bin/mysqld_safe --datadir="/var/lib/mysql" &
# Since we break off, we need to give it time to start up.
sleep 3

# Start cron
# The cacti package installation left a cron file at: /etc/crontabs/cacti
crond -L /var/log/cron

# Start Apache
/usr/sbin/httpd -k start -f /etc/apache2/httpd.conf

# Hold open the session
tail -f /var/log/cacti/cacti.log