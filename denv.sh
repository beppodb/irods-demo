alias startdns1='docker run -d -p 172.17.42.1:53:53/udp --name skydns crosbymichael/skydns -nameserver 8.8.8.8:53 -domain docker'
alias startdns2='docker run -d -v /var/run/docker.sock:/docker.sock --name skydock crosbymichael/skydock -ttl 30 -environment dev -s /docker.sock -domain docker -name skydns'
alias irodsbuild='docker build -t beppodb/idrop-web ~/irods-demo/irods-docker'
alias irodsrunA='FQDN=`hostname -A | sed -e "s/[ \t]*$//"` ; docker run --name irodsa --env ZONENAME=zoneA -h irodsa.idrop-web.dev.docker -v ~/irods-demo/www:/home/admin/www -p 7022:22 -p 7247:1247 -p 7443:8443 -p 7080:80 -e "hostsname=$FQDN" -e "port80=7080" -e "port8443=7443" -d beppodb/idrop-web'
alias irodsrunB='FQDN=`hostname -A | sed -e "s/[ \t]*$//"` ; docker run --name irodsb --env ZONENAME=zoneb -h irodsb.idrop-web.dev.docker -v ~/irods-demo/www:/home/admin/www -h irodsb.idrop-web.dev.docker -p 9022:22 -p 9247:1247 -p 9443:8443 -p 9080:80 -e "hostsname=$FQDN" -e "port80=9080" -e "port8443=9443" -d beppodb/idrop-web'
alias irodsA='ssh -p 7022 admin@localhost'
alias irodsB='ssh -p 9022 admin@localhost'
alias killAB='docker kill irodsa; docker kill irodsb; docker rm irodsa; docker rm irodsb'



