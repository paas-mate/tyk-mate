#!/bin/bash

TYK_HOME=${TYK_HOME}
REDIS_HOST=${TYK_REDIS_HOST}
REDIS_PORT=${TYK_REDIS_PORT}
REDIS_PASS=${TYK_REDIS_PASS}
REDIS_CLUSTER=${TYK_REDIS_CLUSTER}

mkdir -p ${TYK_HOME}/conf
mkdir -p ${TYK_HOME}/apps
mkdir -p ${TYK_HOME}/middleware
mkdir -p ${TYK_HOME}/templates

if [ -z "${REDIS_HOST}" ]
then
    REDIS_HOST="127.0.0.1"
fi

if [ -z "${REDIS_PORT}" ]
then
    REDIS_PORT="6379"
fi

CONF_FILE=${TYK_HOME}/conf/tyk.conf
if [ -f "${CONF_FILE}" ]; then
  echo "${CONF_FILE} exists, just start"
else
  echo "{" >${CONF_FILE}
  echo '    "listen_address": "",' >>${CONF_FILE}
  echo '    "listen_port": 8080,' >>${CONF_FILE}
  echo '    "max_idle_connections_per_host": 500,' >>${CONF_FILE}
  echo '    "template_path": "/opt/tyk/templates",' >>${CONF_FILE}
  echo '    "app_path": "/opt/tyk/apps",' >>${CONF_FILE}
  echo '    "middleware_path": "/opt/tyk/middleware",' >>${CONF_FILE}
  echo '    "enable_separate_cache_store": true,' >>${CONF_FILE}
  echo '    "storage": {' >>${CONF_FILE}
  echo '        "type": "redis",' >>${CONF_FILE}

  echo -n '        "port": ' >>${CONF_FILE}
  echo "${REDIS_PORT}," >>${CONF_FILE}

  echo -n '        "host": "' >>${CONF_FILE}
  echo -n "${REDIS_HOST}" >>${CONF_FILE}
  echo '",' >>${CONF_FILE}

  echo -n '        "password": "' >>${CONF_FILE}
  echo -n "${REDIS_PASS}" >>${CONF_FILE}
  echo '",' >>${CONF_FILE}

  echo -n '        "enable_cluster": ' >>${CONF_FILE}
  echo "${REDIS_CLUSTER}" >>${CONF_FILE}

  echo '    },' >>${CONF_FILE}
  echo '    "uptime_tests": {' >>${CONF_FILE}
  echo '        "disable": true' >>${CONF_FILE}
  echo '    },' >>${CONF_FILE}
  echo '    "hash_keys": true,' >>${CONF_FILE}
  echo '    "hash_key_function": "murmur64"' >>${CONF_FILE}
  echo "}" >>${CONF_FILE}
fi

${TYK_HOME}/tyk start --conf ${CONF_FILE}
