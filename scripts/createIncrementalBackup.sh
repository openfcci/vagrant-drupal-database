#!/bin/bash
DEST="/private/mysql"
cd
source .bash_profile
echo "Performing base backup"
BASE_BACKUP=`ls ${DEST} | head -1`
innobackupex --user=root --password=onlyme  --incremental --defaults-file=/etc/my.cnf ${DEST} --incremental-basedir=${DEST}/${BASE_BACKUP}
