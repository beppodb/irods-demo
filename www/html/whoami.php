<?php
/* $output = shell_exec('../../reset.sh'); */
// $output = shell_exec('../scripts/reset.sh');
$output = posix_getpwuid(posix_geteuid());
echo "<pre>$output[name]</pre>"
// echo "<pre>nl2br($output)</pre>";
?>
