#!/bin/bash
set -o errexit

if [ -z "$SCIDB_DATA_PATH" ]
then
    SCIDB_DATA_PATH=$SCIDB_INSTALL_PATH/DB-$SCIDB_NAME
fi


if [ `lsb_release --id | cut --fields=2` = "CentOS" ]
then
    SSH_SERVICE=sshd
    POSTGRES_SERVICE=postgresql-9.3
else
    SSH_SERVICE=ssh
    POSTGRES_SERVICE=postgresql
fi

service $SSH_SERVICE      start
service $POSTGRES_SERVICE start
service shimsvc           start

# Re-initialize scidb with scidb user
if [ ! -f /scidb_initialized ]; then
        echo "y" | sudo -u scidb $SCIDB_INSTALL_PATH/bin/scidbctl.py init-cluster $SCIDB_NAME
        touch /scidb_initialized
fi

sudo -u scidb $SCIDB_INSTALL_PATH/bin/scidbctl.py start $SCIDB_NAME


trap "$SCIDB_INSTALL_PATH/bin/scidbctl.py stop $SCIDB_NAME;     \
      service $POSTGRES_SERVICE stop"                           \
     EXIT HUP INT QUIT TERM


if [ "$1" = '' ]
then
    tail -f $SCIDB_DATA_PATH/0/0/scidb.log
else
    exec "$@"
fi
