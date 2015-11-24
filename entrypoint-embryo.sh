#!/bin/bash
set -e

if [ "$1" = 'couchdb' ]; then
  # we need to set the permissions here because docker mounts volumes as root

  mkdir -p /data/log
  mkdir -p /data/etc/local.d

  if [ ! -f /data/etc/default.ini ]; then
    cp /usr/local/etc/couchdb/default.ini /data/etc/default.ini.copy
  fi	

  cp /local.ini /usr/local/etc/couchdb/local.ini	
  chown couchdb:couchdb /usr/local/etc/couchdb/local.ini
  
  if [ ! -f /data/etc/local.ini.copy ]; then
    cp /local.ini /data/etc/local.ini.copy	
  fi

  cp /README.txt /data/etc/README.txt	

  cmd="couchdb -p /data/couchdb.pid -n -A /usr/local/etc/couchdb -A /data/etc/local.d"

  if [ -n "$COUCHDB_ADMIN_PASSWORD" ]; then
    mkdir -p /data/etc/local.d
    echo "[admins]" > /data/etc/local.d/admins.ini
    echo "admin = $COUCHDB_ADMIN_PASSWORD" >> /data/etc/local.d/admins.ini
  fi

  chown -R couchdb:couchdb /data
  chmod 0770 /data
  find /data -type d -exec chmod 775 {} \;
  find /data -type f -exec chmod 664 {} \;

  #sudo -i -u couchdb sh -c "$cmd"
  HOME=/data sudo -i -u couchdb sh -c "$cmd"
else
  exec "$@"
fi

