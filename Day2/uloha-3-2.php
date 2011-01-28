<?php
$dir = '/tmp/';
$rep = $dir.'repository_';

// dump
for ($i=1;$i<=10;$i++) {
	exec("svnadmin dump $rep > dump$i.dmp");
	echo "Dump repository $rep" . PHP_EOL;
}
