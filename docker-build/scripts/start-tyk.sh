#!/bin/bash

mkdir -p $TYK_HOME/conf

CONF=$TYK_HOME/conf/tyk.conf
if [ -f "$CONF" ]; then
  echo "$CONF exists, just start"
else
  echo "{" >$CONF
  echo '"listen_address": "",' >>$CONF
  echo '"listen_port": 8080,' >>$CONF
  echo '"max_idle_connections_per_host": 500' >>$CONF
  echo "}" >>$CONF
fi
$TYK_HOME/tyk start --conf $CONF
