#!/bin/bash

USER=$1
PASS=$2

if [ "$PASS" == "" ]; then
  echo "./install.sh <username> <password>"
fi

cp  scripts/* /usr/local/sbin/
sed -i .b "s/USERTOKEN/${USER}/" etc/database_backup.conf
sed -i .b "s/PASSTOKEN/${PASS}/" etc/database_backup.conf
cp etc/database_backup.conf /etc/
