<?php
$dir = '/tmp/';
$rep = $dir.'repository_';
$wc = $dir.'wc_';
// vytvori 10 repository 
for ($i=1;$i<=10;$i++) {
	exec('svnadmin create '.$rep.$i);
	echo "Create repository ".$rep.$i. PHP_EOL;
	// vytvoreni 50 commitu
	for ($j=1;$j<=50;$j++) {
		exec('svn co file:///'.$rep.$i.' '.$wc.$i);
		exec('touch '.$wc.$i.'/commit'.$j);
		exec('svn add '.$wc.$i.'/commit'.$j);
		exec("svn commit ".$wc.$i.'/commit'.$j." -m 'commit$j'");		
		echo "Added commit ".$j.PHP_EOL;
	}
}