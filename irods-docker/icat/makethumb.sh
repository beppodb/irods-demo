#!/bin/bash
THUMBS_FOLDER="/var/www/html/thumbnails"
# next line checks the mime-type of the file
IMAGE_TYPE=`file --mime-type -b "$1" | awk -F'/' '{print $1}'`
echo $IMAGE_TYPE
  if [ $IMAGE_TYPE = "image" ]; then
      IMAGE_SIZE=`file -b $1 | sed 's/ //g' | sed 's/,/ /g' | awk  '{print $2}'`
      WIDTH=`identify -format "%w" "$1"`
      HEIGHT=`identify -format "%h" "$1"`           
      # If the image width is greater that 200 or the height is greater that 150 a thumb is created
     if [ $WIDTH -ge  201 ] || [ $HEIGHT -ge 151 ]; then
        #This line convert the image in a 200 x 150 thumb 
        filename=$(basename "$1")
        extension="${filename##*.}"
        filename="${filename%.*}"
        convert  "$1" -thumbnail 150x150^ -gravity center -extent 150x150 "${THUMBS_FOLDER}/${filename}_thumb.${extension}"   
     fi
  fi
