#!/usr/bin/env bash

set -ex

MAUTIC_DB_NAME=${MAUTIC_DB_NAME-"mautic-tests"}
MAUTIC_ERROR_LOG=${MAUTIC_ERROR_LOG-/tmp/mautic-error.log}

if [ -e app/config/local.php ]; then
  rm -f app/config/local.php
fi

if [ -d app/cache ]; then
  rm -fr app/cache/*
fi

# It always drops and creates a database
if [ ! $MAUTIC_DB_PASS ]; then
  MAUTIC_DB_PASS=""
  mysql -e "drop database IF EXISTS \`$MAUTIC_DB_NAME\`;" -uroot
  mysql -e "create database IF NOT EXISTS \`$MAUTIC_DB_NAME\`;" -uroot
else
  mysql -e "drop database IF EXISTS \`$MAUTIC_DB_NAME\`;" -uroot -p"$MAUTIC_DB_PASS"
  mysql -e "create database IF NOT EXISTS \`$MAUTIC_DB_NAME\`;" -uroot -p"$MAUTIC_DB_PASS"
fi


cat << INI > php.ini
memory_limit = 512M
error_reporting = E_ALL
log_errors = On
error_log = $MAUTIC_ERROR_LOG
INI

php -S 127.0.0.1:8080 -c php.ini
