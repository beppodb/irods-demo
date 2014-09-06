# A really quick and dirty iRODS demo.

You need to have docker installed. You will probably need to update some firewall settings. (See setup.sh).
Then...

```
source ./setup.sh

# Use skydns to permit containers to initiate communication with each other.
skydns_start
skydock_start

# Then fire up two iCAT servers.
irods_build
irods_start
```


