#!/bin/bash
supervisorctl start sshd

supervisorctl start postgresql
supervisorctl start irodsServer
sudo su -c "iadmin modresc demoResc host $HOSTNAME" irods
sudo su -c "iadmin modzone tempZone name $ZONENAME" irods
sudo su -c "sed -i 's/tempZone/$ZONENAME/' /var/lib/irods/.irods/.irodsEnv" irods

#supervisorctl start nginx

#/home/admin/update_idwconfig.sh /etc/idrop-web/idrop-web-config2.groovy
#supervisorctl start tomcat6



