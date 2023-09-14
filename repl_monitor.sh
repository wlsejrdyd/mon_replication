#!/bin/sh

DBNAME="deok"
DBUSER="deok"
DBPASS=""
MYSQLPATH="/usr/local/mysql/bin/mysql"
MYSQL="$MYSQLPATH -u $DBUSER -p${DBPASS} $DBNAME"

HOST="고객사이림"
IP1="Master DB IP"
IP2="Slave DB IP"
IP3="??"

GET="/usr/bin/zabbix_get"
MASTER="repl.master"
SLAVE="repl.slave"

###################################################################################################################################
## KEY
KEY_MASTER=`$GET -s $IP1 -k $MASTER > /opt/$IP1.master`
KEY_SLAVE=`$GET -s $IP2 -k $SLAVE > /opt/$IP2.slave`
MASTER_POS=`/bin/cat /opt/$IP1.master | grep Position | awk '{print $2}'`
SLAVE_POS=`/bin/cat /opt/$IP2.slave | grep Read_Master_Log_Pos | awk '{print $2}'`
SLAVE_STAT=`/bin/cat /opt/$IP2.slave | grep Slave_IO_State`
#CHECK1=`/bin/cat /opt/$IP3* | grep ksms_agentd | wc -l`
CHECK1=`/bin/grep "ksms_agentd" /opt/$IP3* | grep -v "177\|178\|187\|188" | wc -l`
CHECK2=`/bin/ls /opt/$IP1.master | wc -l`
CHECK3=`/bin/ls /opt/$IP2.slave | wc -l`
CHECK4=`/bin/cat /opt/$IP2.slave | grep Running | wc -l`
CHECK5=`/bin/cat /opt/$IP2.slave | grep Last_SQL_Errno | awk '{print $2}'`
###################################################################################################################################
## CHECK 1
if [ $CHECK1 -eq 2 ] ; 
then
echo "update repl_check set agent='UP' where m_ip='$IP1'" | $MYSQL
else
echo "update repl_check set agent='DOWN' where m_ip='$IP1'" | $MYSQL
fi
###################################################################################################################################
## CHECK 2
if [ $CHECK2 -eq 1 ] ; 
then
echo "update repl_check set fm='SUCCESS' where m_ip='$IP1'" | $MYSQL
else
echo "update repl_check set fm='FAIL' where m_ip='$IP1'" | $MYSQL
fi
###################################################################################################################################
## CHECK 3
if [ $CHECK3 -eq 1 ] ; 
then
echo "update repl_check set fs='SUCCESS' where m_ip='$IP1'" | $MYSQL
else
echo "update repl_check set fs='FAIL' where m_ip='$IP1'" | $MYSQL
fi
###################################################################################################################################
## CHECK 4
if [ $CHECK4 -eq 2 ] ; 
then
echo "update repl_check set stat='Yes' where m_ip='$IP1'" | $MYSQL
else
echo "update repl_check set stat='No' where m_ip='$IP1'" | $MYSQL
fi
###################################################################################################################################
## DB INSERT
MYSQL_COUNT1=`echo "select count(*) from repl_check where m_ip='$IP1'" | $MYSQL | tail -n 1`
TIME1=`date +%Y-%m-%d\ %H:%M:%S`
if [ $MYSQL_COUNT1 -eq 0 ]
then
echo "insert into repl_check (host,m_ip,s_ip,mas_pos,sla_pos,sla_stat,errno,time) values ('$HOST','$IP1','$IP2','$MASTER_POS','$SLAVE_POS','$SLAVE_STAT','$CHECK5','$TIME1');" | $MYSQL
else
echo "update repl_check set host='$HOST',mas_pos='$MASTER_POS',sla_pos='$SLAVE_POS',sla_stat='$SLAVE_STAT',errno='$CHECK5',time='$TIME1' where m_ip='$IP1'" | $MYSQL
fi
###################################################################################################################################
## SMS
#echo "HDD_FAIL COUNT = $HDD_FAIL"
#if [ $HDD_FAIL -eq 0 ]
#then
#        echo "HDD FAIL NONE"
#else
#        echo "HDD FAIL COUNT $HDD_FAIL"
#        curl -f -s --max-time 3  --user ServerCheck:diskcheck --data "sv=${IP}_${PRODUCT}&msg=diskcheck" --url http://www.nayana.com
#/~shjin/server_diskcheck.php
#fi
