# A really quick and dirty iRODS demo.

You need to have docker installed. And because this is so brittle, you need to have this installed in ~/irods-docker.
Then...

```
source denv.sh

# I use skydns to permit containers to initiate communication with each other.
docker pull crosbymichael/skydns
docker pull crosbymichael/skydock
startdns1
startdns2

# Then fire up two iCAT servers.
irodsbuild
irodsrunA
irodsrunB
```


