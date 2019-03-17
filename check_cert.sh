#!/bin/bash
# SSL CertFile Expiredate Chechk Script For Nagios
# Created by koitatu(2015/09/25)

### Args Check 
if [ $# -ne 1 ]; then
        echo "invalid args."
        echo "Usage: $0 <Cert File>"
        exit 100;
fi


### Set Env
CERT_FILE=$1
UTC_TODAY=`date +%s`
NOT_AFTEER_DATE=`openssl x509 -in ${CERT_FILE} -text | sed -e "/Not After/{s/^.* : //;p};d"`
UTC_DATE=`date --date="${NOT_AFTEER_DATE}" +%s`
JST_DATE=`date +%Y/%m/%d_%H:%M\(%Z\) --date="${NOT_AFTEER_DATE}"`
EXPIRE_DATE=`date --date="${NOT_AFTEER_DATE}" +%s`
UTC_LEFT=`echo ${EXPIRE_DATE} - ${UTC_TODAY}|bc`
DAYS_LEFT=`expr ${UTC_LEFT} / 86400`

### Main Routine
if [ "${DAYS_LEFT}" -le 15 ]; then
        echo "NG - ${CERT_FILE} is remind ${DAYS_LEFT} days. Expire Date is ${JST_DATE}"
        exit 2;
elif [ "${DAYS_LEFT}" -le 30 ]; then
        echo "WARNING - ${CERT_FILE} is remind ${DAYS_LEFT} days. Expire Date is ${JST_DATE}"
        exit 1;
else    
        echo "OK - ${CERT_FILE} is remind ${DAYS_LEFT} days. Expire Date is ${JST_DATE}"        
        exit 0;
fi

### End Of Routine
