<?PHP
  // Original PHP code by Chirp Internet: www.chirp.com.au
  // Please acknowledge use of this code by including this header.

  $imagetypes = array("image/jpeg", "image/gif");
  $stub = trim(file_get_contents('./stub')) . "/browse/index#treeView=detect&treeViewPath=&absPath=/zoneA/home/alice/images/";
  //echo $stub;

  function getImages($dir)
  {
      global $imagetypes;
    // array to hold return value
    $retval = array();

    // add trailing slash if missing
    if(substr($dir, -1) != "/") $dir .= "/";

    // full server path to directory
    $fulldir = "{$_SERVER['DOCUMENT_ROOT']}/$dir";
    $d = @dir($fulldir) or die("getImages: Failed opening directory $dir for reading");
    while(false !== ($entry = $d->read())) {
      // skip hidden files
      if($entry[0] == ".") continue;

      // check for image files
      $f = escapeshellarg("$fulldir$entry");
      $mimetype = trim(`file -bi $f`);
      foreach($imagetypes as $valid_type) {
        if(preg_match("@^{$valid_type}@", $mimetype)) {
          $retval[] = array(
           'filename' => "$entry",
           'file' => "/$dir$entry",
           'size' => getimagesize("$fulldir$entry")
          );
          break;
        }
      }
    }
    $d->close();
    return $retval;
  }

  $images = getImages("thumbnails");
 // display on page  
//    echo "<ul>";
  echo "<ul id=\"photos\">";
  foreach($images as $img)
{
    echo "<li style=\"list-style-type:none;\">";
    $irodsname = $stub . str_replace("_thumb","",$img['filename']);
    echo "<a href=\"{$irodsname}\" target=\"_blank\">";
    echo "<img src=\"{$img['file']}\" {$img['size'][3]} alt=\"\"><br>\n";    // display image file name as link
    echo "</a>";
    echo "</li>";

  }
    echo "</ul>";


echo "<script src=\"jquery.min.js\"></script>";
echo "<script src=\"jquery.wookmark.js\"></script>";

echo <<<'DOC'
  <script type="text/javascript">
  (function ($){ 
      $(function() {
        var $handler = $('#photos li');

        $handler.wookmark({
            // Prepare layout options.
            autoResize: true, // This will auto-update the layout when the browser window is resized.
//            container: $('#main'), // Optional, used for some extra CSS styling
            offset: 5, // Optional, the distance between grid items
            outerOffset: 10, // Optional, the distance to the containers border
            itemWidth: 220 // Optional, the width of a grid item
        });
      });
    })(jQuery);
  </script>
DOC;


?>
