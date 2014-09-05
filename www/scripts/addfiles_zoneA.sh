#!/bin/bash
IRODSUSER="alice"
IRODSENV="/var/www/scripts/irodsEnv.USER_A"
IMGDIR="/var/www/images"

cp $IRODSENV /home/admin/.irods/.irodsEnv
echo -e "$IRODSUSER\n" | iinit
imkdir images
icd images
#
IMGFILE="sanger.jpg"
IMGPATH="$IMGDIR/$IMGFILE"
iput $IMGPATH
RES=`convert $IMGPATH -print "%wx%h" /dev/null`
imeta add -d $IMGFILE sanger $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE consortiumMember $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE WTSI  $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE irodsUser $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE $RES $IRODSUSER iRODSUserTagging:Tag
#
IMGFILE="ddn.jpg"
IMGPATH="$IMGDIR/$IMGFILE"
iput $IMGPATH
RES=`convert $IMGPATH -print "%wx%h" /dev/null`
imeta add -d $IMGFILE ddn $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE consortiumMember $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE storageVendor  $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE rack $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE $RES $IRODSUSER iRODSUserTagging:Tag
#
IMGFILE="emc.jpg"
IMGPATH="$IMGDIR/$IMGFILE"
iput $IMGPATH
RES=`convert $IMGPATH -print "%wx%h" /dev/null`
imeta add -d $IMGFILE emc $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE consortiumMember $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE storageVendor  $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE rack  $IRODSUSER iRODSUserTagging:Tag
imeta add -d $IMGFILE $RES $IRODSUSER iRODSUserTagging:Tag
