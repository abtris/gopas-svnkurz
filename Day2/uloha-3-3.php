<?php
$dir = '/tmp/';
$rep = $dir.'repository_';

// dump
for ($i=1;$i<=10;$i++) {
	exec('svnadmin create '.$rep.$i);
	echo "Create repository ".$rep.$i. PHP_EOL;	
	exec("svnadmin load $rep < dump$i.dmp");
	echo "Load repository $rep" . PHP_EOL;
}
