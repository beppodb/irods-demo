# A really quick and dirty iRODS demo.

You need to have docker installed. And because this is so brittle, you need to have this installed in ~/irods-docker.
Then...

```
source ./setup.sh

# I use skydns to permit containers to initiate communication with each other.
skydns_start
skydock_start

# Then fire up two iCAT servers.
irods_build
irods_start
```


