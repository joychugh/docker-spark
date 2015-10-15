#!/usr/bin/env bash
export SPARK_LOCAL_IP=`awk 'NR==1 {print $1}' /etc/hosts`
MASTER_IP="MASTER_PORT_${SPARK_MASTER_PORT}_TCP_ADDR"
/opt/spark/sbin/start-slave.sh spark://${!MASTER_IP}:${SPARK_MASTER_PORT} -h ${SPARK_LOCAL_IP}
tail -f /dev/null