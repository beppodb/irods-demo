#!/bin/bash
IRODSENV="/var/www/scripts/irodsEnv.rodsA"
IRODSUSER="rods"
cp $IRODSENV /home/admin/.irods/.irodsEnv
echo -e "$IRODSUSER\n" | iinit

iadmin mkzone zoneB remote irodsb.idrop-web.dev.docker:1247
iadmin mkuser rods#zoneB rodsuser
iadmin mkuser stan#zoneB rodsuser

sudo su -c "cp /var/www/scripts/server.configA /etc/irods/server.config" root

IRODSENV="/var/www/scripts/irodsEnv.rodsB"
cp $IRODSENV /home/admin/.irods/.irodsEnv
echo -e "$IRODSUSER\n" | iinit

iadmin mkzone zoneA remote irodsa.idrop-web.dev.docker:1247
iadmin mkuser rods#zoneA rodsuser
iadmin mkuser ashok#zoneA rodsuser

IRODSENV="/var/www/scripts/irodsEnv.stan"
IRODSUSER="stan"
cp $IRODSENV /home/admin/.irods/.irodsEnv
echo -e "$IRODSUSER\n" | iinit
ichmod -r inherit /zoneB/home/stan/images
ichmod -r read ashok#zoneA /zoneB/home/stan/images
