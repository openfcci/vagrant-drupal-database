#!/bin/bash
DEST="/private/mysql"
cd
source .bash_profile
echo "Performing base backup"
innobackupex --user=root --password=onlyme  --defaults-file=/etc/my.cnf ${DEST} &> /dev/null
FILE=`ls ${DEST}`
echo "Applying log"
innobackupex --apply-log ${DEST}/${FILE}  &> /dev/null
echo "Performing restore"
ssh root@recover.local "./restore.sh"
