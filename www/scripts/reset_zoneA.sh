#!/bin/bash
cd /
ZONENAME="zoneA"
IRODSUSER="alice"
supervisorctl stop irodsServer

# rebuild the iCAT db
sudo -u postgres dropdb 'ICAT'
sudo -u postgres createdb -O postgres 'ICAT' -E UTF8 -l en_US.UTF-8 -T template0 
sudo -u postgres psql -U postgres -d postgres -c 'GRANT ALL PRIVILEGES ON DATABASE "ICAT" TO irods'
sudo tail -n+3 /home/admin/dbresp | /var/lib/irods/packaging/setup_irods.sh

# stop irods background process and restart as supervisorctl process
sudo /etc/init.d/irods stop
supervisorctl start irodsServer
# change the zonename
CALLSTRING="echo -e \"y\n\" | iadmin modzone tempZone name $ZONENAME"
sudo su -c "$CALLSTRING" irods
CALLSTRING="sed -i 's/tempZone/$ZONENAME/' /var/lib/irods/.irods/.irodsEnv"
sudo su -c "$CALLSTRING" irods

CALLSTRING="echo -e \"y\n\" | iadmin modresc demoResc name OldStorage"
sudo su -c "$CALLSTRING" irods

CALLSTRING="iadmin mkuser $IRODSUSER rodsuser"
sudo su -c "$CALLSTRING" irods
CALLSTRING="iadmin moduser $IRODSUSER password $IRODSUSER"
sudo su -c "$CALLSTRING" irods

CALLSTRING="iadmin mkuser anonymous rodsuser"
sudo su -c "$CALLSTRING" irods

rm /var/www/html/thumbnails/*.jpg
CALLSTRING="/var/www/scripts/addfiles_$ZONENAME.sh"
sudo su -c "$CALLSTRING" admin
