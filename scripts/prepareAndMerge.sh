#!/bin/bash
DEST="/private/mysql"
cd
source .bash_profile

unset BASE_BACKUP


ls ${DEST} > $$tmp
NUM_DIRS=`cat $$tmp | wc -l | sed -e 's/^[ \t]*//'`
CYCLE=0

while read CUR_DIR
do
#  CYCLE=`echo "${CYCLE} + 1" | bc`
  if [ "${BASE_BACKUP}" == "" ]; then
    BASE_BACKUP=${CUR_DIR}
    echo "applying logs to base backup"
    innobackupex --apply-log --redo-only ${DEST}/${BASE_BACKUP}
  else
    echo "$CYCLE vs $NUM_DIRS"
    if [ ${CYCLE} -lt ${NUM_DIRS} ]; then
      echo "applying redo only logs to incremental"
      innobackupex --apply-log --redo-only ${DEST}/${BASE_BACKUP} --incremental-dir=${DEST}/${CUR_DIR}
    else
      echo "applying logs to incremental"
      innobackupex --apply-log ${DEST}/${BASE_BACKUP} --incremental-dir=${DEST}/${CUR_DIR}
    fi 

    if [ "${?}" == "0" ]; then
      rm -rf ${DEST}/${CUR_DIR}
    else
      echo "failed to apply incremental ${DEST}/{$CUR_DIR}, ${DEST}/${BASE_BACKUP} is probably inconsistent, sorry!"
    fi
    
  fi
done < $$tmp
#innobackupex --apply-log ${DEST}/${BASE_BACKUP}
rm -f $$tmp
