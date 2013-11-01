sudo apt-get install vim mc tree
sudo apt-get install apache2 libapache2-svn

# make repos and structure
mkdir -p /home/student/gopas/repos
mkdir -p /home/student/gopas/wc
svnadmin create /home/student/gopas/repos/Team1
svnadmin create /home/student/gopas/repos/Team2
mkdir -p /home/student/gopas/wc/xxxx
cd /home/student/gopas/wc/xxxx
mkdir tags trunk branches
svn import file:///home/student/gopas/repos/Team1 -m "Added Structure"
svn import file:///home/student/gopas/repos/Team2 -m "Added Structure"

# make Right
sudo htpasswd -bc /etc/apache2/dav_svn.passwd Petr heslo
sudo htpasswd -b /etc/apache2/dav_svn.passwd Jan heslo
sudo htpasswd -b /etc/apache2/dav_svn.passwd Lada heslo
sudo htpasswd -b /etc/apache2/dav_svn.passwd Pavel heslo
sudo cp dav_svn.authz /etc/apache2/dav_svn.authz
sudo cp dav_svn.conf /etc/apache2/modes-available/dav_svn.conf
sudo a2enmod authz_svn
sudo /etc/init.d/apache2 restart
