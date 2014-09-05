#!/bin/bash
IRODSENV="/var/www/scripts/irodsEnv.rodsA"
IRODSUSER="rods"
cp $IRODSENV /home/admin/.irods/.irodsEnv
echo -e "$IRODSUSER\n" | iinit

iadmin mkzone zoneB remote irodsb.irods-demo.dev.docker:1247
iadmin mkuser bobby#zoneB rodsuser

sudo su -c "cp /var/www/scripts/server.configA /etc/irods/server.config" root

IRODSENV="/var/www/scripts/irodsEnv.rodsB"
cp $IRODSENV /home/admin/.irods/.irodsEnv
echo -e "$IRODSUSER\n" | iinit

iadmin mkzone zoneA remote irodsa.irods-demo.dev.docker:1247
iadmin mkuser alice#zoneA rodsuser

IRODSENV="/var/www/scripts/irodsEnv.USER_B"
IRODSUSER="bobby"
cp $IRODSENV /home/admin/.irods/.irodsEnv
echo -e "$IRODSUSER\n" | iinit
ichmod -r inherit /zoneB/home/bobby/images
ichmod -r read alice#zoneA /zoneB/home/bobby/images
