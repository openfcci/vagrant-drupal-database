#!/bin/bash
source /etc/database_backup.conf

innobackupex --user=${DBUSER} --password=${DBPASS}  --defaults-file=/etc/mysql/my.cnf ${DEST} &> /dev/null
