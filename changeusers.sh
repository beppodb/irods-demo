#!/bin/bash
# Usage: ./changeusers.sh [old user A] [old user B] [new user A] [new user B]
# RUN BEFORE irodsbuild (because of core.re)

OLD_A=$1
OLD_B=$2
NEW_A=$3
NEW_B=$4
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sed -i "s/$OLD_A/$NEW_A/g" $DIR/www/scripts/fza.sh 
sed -i "s/$OLD_A/$NEW_A/g" $DIR/www/scripts/addfiles_zoneA.sh 
sed -i "s/$OLD_A/$NEW_A/g" $DIR/www/scripts/irodsEnv.USER_A 
sed -i "s/$OLD_A/$NEW_A/g" $DIR/www/scripts/reset_zoneA.sh
sed -i "s/$OLD_A/$NEW_A/g" $DIR/www/html/thumbnails/index.php
sed -i "s/$OLD_A/$NEW_A/g" $DIR/www/html/index.html
sed -i "s/$OLD_B/$NEW_B/g" $DIR/www/scripts/fza.sh
sed -i "s/$OLD_B/$NEW_B/g" $DIR/www/scripts/addfiles_zoneB.sh
sed -i "s/$OLD_B/$NEW_B/g" $DIR/www/scripts/irodsEnv.USER_B
sed -i "s/$OLD_B/$NEW_B/g" $DIR/www/scripts/reset_zoneB.sh
sed -i 's/$OLD_B/$NEW_B/g' $DIR/www/html/index.html




 
