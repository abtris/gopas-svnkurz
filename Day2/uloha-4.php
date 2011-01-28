<?php
$log = "uloha-4.xml";

if (file_exists($log)) {
    $xml = simplexml_load_file($log);
	$out = 'REVISION;AUTHOR;DATE;MESSAGE' . PHP_EOL;
	foreach ($xml->logentry as $i) {
		$out .= $i['revision']. ';' .$i->author .';'.$i->date . ';' . $i->msg. PHP_EOL;
	}
	file_put_contents('uloha-4.csv', $out);
}