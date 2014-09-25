#!/bin/bash
sudo su -c "/var/www/scripts/migrate.sh zoneA OldStorage NewStorage irodsa.irods-demo.dev.docker:/var/lib/irods/newResc" irods

