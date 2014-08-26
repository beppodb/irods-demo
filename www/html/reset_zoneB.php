<?php
/* $output = shell_exec('../../reset.sh'); */
$output = shell_exec('../scripts/reset_zoneB.sh');
/* $output = posix_getpwuid(posix_geteuid());
echo "<pre>$output[name]</pre>" */
$output = nl2br($output);
echo "<pre>$output<br><script>window.close();</script></pre>";
?>
