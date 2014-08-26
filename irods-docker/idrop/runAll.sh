#!/bin/bash
supervisorctl start sshd

supervisorctl start postgresql
supervisorctl start irodsServer
su -c "iadmin modresc demoResc host $HOSTNAME" irods
su -c 'echo -e "y\n" | iadmin modzone tempZone name $ZONENAME' irods
su -c 'sed -i "s/tempZone/$ZONENAME/" /var/lib/irods/.irods/.irodsEnv' irods

/home/admin/update_idwconfig.sh /etc/idrop-web/idrop-web-config2.groovy
supervisorctl start tomcat6



