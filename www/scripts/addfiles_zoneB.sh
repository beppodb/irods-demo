#!/bin/bash
IRODSUSER="stan"
IRODSENV="/var/www/scripts/irodsEnv.stan"
IMGDIR="/var/www/images"

cp $IRODSENV /home/admin/.irods/.irodsEnv
echo -e "$IRODSUSER\n" | iinit
imkdir images
icd images
#
IMGFILE="ncdc.jpg"
IMGPATH="$IMGDIR/$IMGFILE"
iput $IMGPATH
RES=`convert $IMGPATH -print "%wx%h" /dev/null`
imeta add -d $IMGFILE NCDC $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE scientificData $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE climateData $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE irodsUser $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE $RES $IRODSUSER iRODSUserTagging:Tag
#
IMGFILE="bnf.jpg"
IMGPATH="$IMGDIR/$IMGFILE"
iput $IMGPATH
RES=`convert $IMGPATH -print "%wx%h" /dev/null`
imeta add -d $IMGFILE BnF $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE library $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE $RES $IRODSUSER iRODSUserTagging:Tag
#
IMGFILE="nasagoddard.jpg"
IMGPATH="$IMGDIR/$IMGFILE"
iput $IMGPATH
RES=`convert $IMGPATH -print "%wx%h" /dev/null`
imeta add -d $IMGFILE NASA $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE irodsUser $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE scientificData  $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE climateData $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE $RES $IRODSUSER iRODSUserTagging:Tag
