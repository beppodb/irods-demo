#!/bin/bash

# replaces prefixes in idrop-web-config2.groovy with environment variables that
# should be configured by docker at runtime

sed -i 's/serverURL.*/serverURL = \"http:\/\/'"$hostsname"':'"$port8443"'\/idrop-web2\" \}/g; 
    s/idrop\.lite\.codebase.*/idrop\.lite\.codebase=\"http:\/\/'"$hostsname"':'"$port80"'\/idrop-release\"/g;
    s/idrop\.jnlp.*/idrop\.jnlp=\"http:\/\/'"$hostsname"':'"$port80"'\/idrop-release\/idrop\.jnlp\"/g;
    s/idrop.config.preset.zone=.*/idrop.config.preset.zone=\"'"$ZONENAME"'\"/g' $1




