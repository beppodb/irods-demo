#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FQDN=`hostname -A | sed -e "s/[ \t]*$//"`
DOCKERIP=`/sbin/ifconfig docker0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`

# this will only match on the first run
sed -i "s/template.example.org/$FQDN/g" $DIR/www/html/index.html

echo 'This script assumes that docker is already installed. Using version 1.1.1'
echo 'or later is recommended.'
echo
echo 'This script assumes that the user has permission to run docker without sudo.'
echo
echo 'For details, see'
echo '    https://docs.docker.com/installation/binaries/#giving-non-root-access'
echo

alias skydns_start='docker run -d -p '$DOCKERIP':53:53/udp --name skydns crosbymichael/skydns -nameserver 8.8.8.8:53 -domain docker'
alias skydock_start='docker run -d -v /var/run/docker.sock:/docker.sock --name skydock crosbymichael/skydock -ttl 30 -environment dev -s /docker.sock -domain docker -name skydns'
alias irods_build='docker build -t irods/irods-demo '$DIR/irods-docker''
alias irods_start_A='docker run --name irodsa --env ZONENAME=zoneA -h irodsa.irods-demo.dev.docker -v '$DIR/www':/home/admin/www -p 7022:22 -p 7247:1247 -p 7443:8443 -p 7080:80 -e "hostsname=$FQDN" -e "port80=7080" -e "port8443=7443" -d irods/irods-demo'
alias irods_start_B='docker run --name irodsb --env ZONENAME=zoneb -h irodsb.irods-demo.dev.docker -v '$DIR/www':/home/admin/www -p 9022:22 -p 9247:1247 -p 9443:8443 -p 9080:80 -e "hostsname=$FQDN" -e "port80=9080" -e "port8443=9443" -d irods/irods-demo'
alias irods_ssh_A='ssh -p 7022 admin@localhost'
alias irods_ssh_B='ssh -p 9022 admin@localhost'
alias irods_stop='docker kill irodsa; docker kill irodsb; docker rm irodsa; docker rm irodsb'
alias irods_start='irods_start_A; irods_start_B'
alias irods_restart='irods_stop; irods_start'

echo 'To access this demonstration from outside the host computer, you may'
echo 'need to open the following ports in your firewall: 7080, 7443.'
echo
echo 'To make the aliases work, you will need to run this script each time'
echo 'you open a new shell.'
echo

