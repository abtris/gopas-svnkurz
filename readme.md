h1. Verzovací systémy

h2. Základní pojmy

Repository (repozitář, centrální úložiště)

Umožňuje organizovat projekt a spravovat jeho verze. Fyzicky je uloženo na souborovém systému serveru. K repository se přistupuje přes Repository Access Layer (RA) systému Subversion a jeho správa se provádí klientskými nástroji.

Branch (větev)

Slouží k organizaci repository, jedná se o jakousi analogii s adresáři. Pokud se z repository vyzvedne větev, na klientovi vznikne adresářová struktura, která přesně odpovídá větvím v repository.

Revision (revize)

Revize je pořadové číslo každé změny. Slouží ke sledování změn ve větvích v čase. Každá změna v nějaké větvi vytvoří novou revizi v rámci celé repository. Revize obsahuje informace o tom, co bylo změněno, kdo změnu provedl, poznámku a čas.

Pracovní kopie (working copy)

Kopie dat z určité větve z repository v aktuální revizi na pevný disk lokálního klienta. Do pracovní kopie je možné provádět změny, které je možné commitem uložit zpět do repository.

Commit

Odeslání změn provedených od posledního commitu do repository. Commit je nejčastěji používaná změna při práci s repository. Pokud se provádí commit celé pracovní kopie, jedná se o atomickou operaci, jsou odeslány veškeré změny ve všech objektech ve správě verzí; pokud dojde k nějaké chybě při přenosu, není commit pro ostatní uživatele repository zviditelněn, není vytvořena nová revize.

Konflikt

Konflikt je stav, který signalizuje, že stejný objekt, který má být právě commitován, byl změněn někým jiným a nachází se v repository v aktuální revizi v jiné podobě, než jaký je v pracovní kopii. Nelze provést commit celé pracovní kopie, pokud se v ní nachází jeden nebo více souboru v konfliktu.

Cheap-copy

Technika, kterou se realizují kopie prováděné v rámci repository. Objekty nejsou v repository fyzicky duplikovány, ale jsou vytvořeny tzv. odkazy (link) na kopírované objekty. Zjednodušeně lze chápat takovýto link jako informaci o URL s číslem revize. Díky tomu má SVN nízké nároky na datový prostor.

h2. Historie verzovacích systémů
h2. Úvod do systému Subversion
h2. Architektura systému
h2. Instalace serveru

h3. Windows
h3. Linux

h2. Instalace klienta

h3. Windows
h3. Linux

h2. Administrace serveru

Repository
Hooks
apojení na LDAP, Active Directory
Správa práv
Tvorba mirroru
Práce s klientem

Základní workflow
Přidávání, kopírování, přejmenování a přesun souborů
Práce s větvemi (branches) a tagy
Práce se zámky
Subversion properties
Příkazy svn blame, svn cleanup, svn export
Migrace z jiného verzovacího systému

Při migraci je vždy potřeba zvažovat zda opravdu potřebujete historii projektu nebo ne. Pokud máte situaci lehčí a ušetříte i diskové kapacity apod. Prostě uděláte export s produkčních verzí a z aktuálně vyvýjených verzí a ty importujete do SVN.

Pokud budete chtít i historii, je potřeba to udělat pomocí některého nástroje.

Migrace z CVS

Migrace z Visual SourceSafe

Migrace z Mercurial nebo Git

h2. Doporučené postupy

h3. Struktura repository
1.
repository_name	/trunk
			/branches
			/tags
2.
repository_name / module 	/ trunk
				     	/ branches
					/ tags
3.
repository_name	/trunk	/ module_1
					/ module_2
			/branches	/ module_1_branch_1
					/ module_2_branch_1
					/ module_1_branch_2
			/tags		/ module_1_tag_1


h3. Nezamykání souborů pro některé soubory

SVN pracuje narozdíl od jiných verzovacích systémů jako v režimu nezamykání což usnadňuje velmi práci s ním. Pokud, ale pracujete s binárnámi soubory je dobré přejít na systém s zamýkáním souborů.


h3. Jak pracovat s commity

- Use a sane repository layout
- Commit logical changesets
- Use the issue-tracker wisely
- Track merges manually
- Understand mixed-revision working copies
- Know when to create branches
	- The Never-Branch system
Pros: Very easy policy to follow. New developers have low barrier to entry. Nobody needs to learn how to branch or merge.
Cons: Chaotic development, code could be unstable at any time
	- The Always-Branch system
Pros: /trunk is guaranteed to be extremely stable at all times.
Cons: Coders are artificially isolated from each other, possibly creating more merge conflicts than necessary. Requires users to do lots of extra merging.
	- The Branch-When-Needed system
Pros: /trunk is guaranteed to be stable at all times. The hassle of branching/merging is somewhat rare.
Cons: Adds a bit of burden to users' daily work: they must compile and test before every commit.

Commit rules
- syntax
- commit type
- commit description
- svn:keywords
napr. 
http://docs.limesurvey.org/tiki-index.php?page=Standard+for+subversion+commit+messages
http://framework.zend.com/wiki/display/ZFDEV/Subversion+Standards
http://www.tigris.org/nonav/scdocs/SVNTips

h3. Jak pracovat s větvemi (branches, vendor branches)

h2. Continues integration (releases)

Celý proces od vytvoření kódu až po provoz na produkčním serveru probíhá v cyklech, proto ta neustálá integrace. 

Build server (CruiseControl, Hudson, Bamboo, ...) si stahuje kód z SVN, provádí celou řadu úkonů (pouští testy, vytváří api dokumentaci, vyváří balíky, spouští nástroje pro QA), které končí například nahrání balíků do úložiště. 
Instalační systém (CFEngine, http://reductivelabs.com/trac/puppet, http://www.capify.org) provede instalaci na prostředí. 

Po instalaci se provedou testy. 

Ohlášené chyby se opraví a zase dokola. 

Případně se posuneme o prostředí dále. Počet prostředí je různý a velmi závisí na infrastruktuře toho co vyvíjíme, pro jednoduchost budou naše prostředí tato: DEVELOPMENT, TESTING a PRODUCTION.

h2. Jak psát hook skripty a kdy to má smysl

Hook skripty jsou užitečné pro kontrolu dat odesílaných na server. Můžete kontrolovat validitu dokumentů v XML (xmllint) nebo formální správnost kódu v PHP (php -l) apod. 

Hook skripty se dají psát v bash i v jiných jazycích, které operační systém na kterém to spouštíte umí interpetovat.

K dispozici máme tyto typy hook skriptů:
post-commit
- po úspěšném commitu můžete například odeslat mail do konference, spusti build apod.
post-lock
post-revprop-change
post-unlock
pre-commit
- kontrola XML, PHP, LOGu
<code>
#!/bin/sh
REPOS="$1"
TXN="$2"
SVNLOOK=/usr/bin/svnlook
PHP="/usr/bin/php"
AWK="/usr/bin/awk"
GREP="/bin/egrep"
SED="/bin/sed"
XMLLINT="/usr/bin/xmllint"
TMP="/tmp/xmlout"
ERR="/tmp/errors"

# check php
CHANGED=`$SVNLOOK changed -t "$TXN" "$REPOS" | $AWK '{print $2}' | $GREP \\.php$`

for FILE in $CHANGED
do
MESSAGE=`$SVNLOOK cat -t "$TXN" "$REPOS" "$FILE" | $PHP -l `

if [ $? -ne 0 ]
then
echo 1>&2
echo "***********************************" 1>&2
echo "PHP error in: $FILE:" 1>&2
echo `echo "$MESSAGE" | $SED "s| -| $FILE|g"` 1>&2
echo "***********************************" 1>&2
exit 1
fi
done

# check xml
CHANGEDXML=`$SVNLOOK changed -t "$TXN" "$REPOS" | $GREP '^[^D].*\.(xml|xsl[t]?)$' | $AWK '{print $2}'`
#OCCHANGEDXML=`$SVNLOOK changed -t "$TXN" "$REPOS" |  $AWK '{print $2}'| grep \\.xml$`
#echo $CHANGEDXML >> $ERR

for FILE in $CHANGEDXML
do      
                $SVNLOOK cat -t "$TXN" "$REPOS" "$FILE" > $TMP
                OUT=`$XMLLINT --noout $TMP 2>&1`
                if [ $? -ne 0 ] 
                        then
                        echo "---------------------------------------" >&2
                        echo "XML error in: $FILE:" >&2
                        echo "---------------------------------------" >&2
                        echo $OUT >&2
                        exit 1
                fi                           
done

# Make sure that the log message contains some text.
SVNLOOKOK=1
$SVNLOOK log -t "$TXN" "$REPOS" | \
   grep "[a-zA-Z0-9]" > /dev/null || SVNLOOKOK=0
if [ $SVNLOOKOK = 0 ]; then
echo "Empty log messages are not allowed. Please provide a proper log message." 1>&2
exit 1
fi
 
# All checks passed, so allow the commit.
exit 0
</code>
pre-lock
pre-revprop-change
- slouží pro možnost měnit svn:log property, ale nic jiného
pre-unlock
start-commit
- například pokud máte mirror dá se tímto hookem kontrolovat, aby zápis prováděl jen specifický uživatel
<code>
#!/bin/sh

USER="$2"

if [ "$USER" = "svnsync" ]; then exit 0; fi

echo "Only the svnsync user may commit new revisions" >&2
exit 1
</code>


h2. Integrace Subversion

Pokud potřebujete integrovat podporu SVN do svojí aplikace máte asi dvě možnosti. Buď použijete wrapper nad řádkovým klientem SVN nebo nativní knihovnu pro jazyk. V jazyce Java se používá knihovna SVNKit (http://svnkit.com), v DOT NET je klihovna SVN.NET (http://www.pumacode.org/projects/svndotnet/). Obě tyto knihovny využívají API SVN. 

h3. IDE integrace
Většina vývojových prostředí má podporu pro správu verzí. Většina jich v základu obsahuje podporu pro SVN (Netbeans, Eclipse a jejich klony, JetBrains IDEA), případně je nutné doinstalovat nějaké pluginy pro další VCS.

h3. Webové rozhraní k repositářům

Webových rozhraní k repositářům SVN je několik. Přímo můžete použít Apache, kde vidíte jen obsah repositářů. Vzhled se dá upravit pomocí XSL. 
Existuje například rozšíření ViewVC, které poskytne pěkný browser kódu i s procházení verzí, čtení logů. Možnost změny vzhledu apod.
Mezi další prohlížeče kódu (code browser) patří Atlassian FishEye, který má možnost rozšíření na Crucible, který přidá možnost Code Review.

Open Source varianta Code Review je například Groogle (http://groogle.sourceforge.net/), který je napsaný v PHP.

h3. Ant integrace

V Antu je potřeba volat řádkového klienta s potřebnými parametry. Je tu ukázka jak získáte pomocí nástrojů svn, grep a awk informace o revizi.

Vlastní příkaz vypadá takto:
svn info rep_url | grep 'Last Changed Rev' | awk '{print $4}'

přepis do Antu vypadá takto:

 <target name="svnrevision" unless="REV" depends="init">
   <exec executable="svn" output="${build_root}/svninfo">
     <arg value="info"/>
     <!-- add trust-server-cert option for SVN 1.6 -->          
     <arg value="--non-interactive"/>      
     <arg value="${rep_url}"/>
   </exec>
   <exec executable="grep" output="${build_root}/grepinfo">
     <arg value="Last Changed Rev" />
     <arg value="${build_root}/svninfo" />
   </exec>
   <exec executable="gawk" outputproperty="REV">
     <arg value="{print $4}"/>
     <arg value="${build_root}/grepinfo"/>
   </exec>
   <echo message="REV: ${REV}" />
 </target>

Literatura a použité zdroje

[SVN] Subversion. URL: http://subversion.tigris.org/.

[BZR] Bazaar VCS. URL: http://bazaar-vcs.org/.

[WIKISVN] Wikipedia Subversion. URL: http://cs.wikipedia.org/wiki/Subversion/.

[DB] Docbook. URL: http://www.docbook.cz.

SVN klienti

[TSVN] TortoiseSVN. URL: http://tortoisesvn.tigris.org/.

[SUBCLIPSE] Subclipse. URL: http://subclipse.tigris.org/.

[SUBVERSIVE] Subversive. URL: http://www.eclipse.org/subversive/.

[ANKHSVN] AnkhSVN. URL: http://ankhsvn.open.collab.net/.

[RSVN] RapidSVN. URL: http://rapidsvn.tigris.org/.

[VISUALSVN] VisualSVN : Subversion for Visual Studio. URL: http://www.visualsvn.com/visualsvn/.

SVN servery

[VSVN] VisualSVN server. URL: http://www.visualsvn.com/server/.

Programovací prostředí - IDE

[ECLIPSE] Eclipse. URL: http://www.eclipse.org/.

[ZEND] Zend Studio for Eclipse. URL: http://www.zend.com/en/products/studio/.

[NB] NetBeans. URL: http://www.netbeans.org/.

[KOMODO] Komodo IDE. URL: http://www.activestate.com/Products/komodo_ide/.

[VS] MS Visual Studio. URL: http://msdn.microsoft.com/cs-cz/vstudio/.

Dokumentace

[SVNBOOK] SVN book. URL: http://svnbook.red-bean.com/.