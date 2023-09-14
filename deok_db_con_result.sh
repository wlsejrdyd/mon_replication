#!/bin/bash

date=`date +'%Y%m%d'`
date1=`date +'%Y%m%d %T'`
dbuser="gwuser"
dbpw='qqq123'
bin='/usr/bin/mysql'
res1=`cat "/root/${date}_dbconn.txt" | grep conn | awk '{print $2}' | sort -r | head -1`
echo -e "############################\nTIME ${date1} \n\033[0;32m[1]_Results Case 1\033[0m" >> /root/${date}_dbconn.txt
$bin -u$dbuser -p${dbpw} -e "show status like '%reads_conn%';" | grep "conn" >> /root/${date}_dbconn.txt
echo -e "\033[0;32m[2]_Results Case 2\033[0m\nMax Value : $res1 \n############################\n" >> /root/${date}_dbconn.txt