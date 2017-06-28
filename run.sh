#!/bin/sh

set -eu 

FQ_PATH=$(readlink -f $0)
FQ_DIR=$(dirname $FQ_PATH)

. ${FQ_DIR}/conf/general

CONF_VARS="TARGET TIMEOUT EX_RESULT METRIC_ID DEFAULT"

for t in $(find ${FQ_DIR}/conf -type f | grep -v general);do 
	unset $CONF_VARS
	. /$t	
	TMP=$(mktemp)	
	curl -m $TIMEOUT -o /dev/null -s -w "%{time_total}\n" $TARGET 2>&1 > $TMP || echo $DEFAULT > $TMP 	
	RES_MS=$(cat $TMP)
	rm $TMP
	curl -s -o /dev/null -H "X-Cachet-Token: $TOKEN" -X POST "${API_URL}/metrics/${METRIC_ID}/points?timestamp=$(date +%s)&id=$METRIC_ID&value=$RES_MS"
	echo "$TARGET TIMEOUT=$TIMEOUT EX_RESULT=$EX_RESULT METRIC_ID=$METRIC_ID RES_MS=$RES_MS"
done
