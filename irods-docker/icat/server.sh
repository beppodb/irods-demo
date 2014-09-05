#!/bin/bash
cd /var/lib/irods/iRODS/server/bin
env PATH="$PATH:/var/lib/irods/iRODS/server/bin" ./irodsServer -u >> /var/lib/irods/iRODS/server/log/rodsLog.log
