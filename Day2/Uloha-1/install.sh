sudo apt-get install vim mc tree
sudo apt-get install apache2 libapache2-svn

# make Repos and structure
mkdir -p /home/student/Gopas/REPOS
mkdir -p /home/student/Gopas/WC
svnadmin create /home/student/Gopas/REPOS/Team1
svnadmin create /home/student/Gopas/REPOS/Team2
svn co file:///home/student/Gopas/REPOS/Team1
cd /home/student/Gopas/REPOS/Team1
mkdir tags trunk branches
svn add tags trunk branches
svn commit -m "Added structure"
mkdir -p /home/student/Gopas/WC/xxxx
cd /home/student/Gopas/WC/xxxx
mkdir tags trunk branches
svn import file:///home/student/Gopas/REPOS/Team2 -m "Added Structure"

# make Right
# sudo vim /etc/apache2/modes-available/dav_svn.conf 
# sudo vim  /etc/apache2/dav_svn.authz
sudo htpasswd -bc /etc/apache2/dav_svn.passwd Petr heslo
sudo htpasswd -b /etc/apache2/dav_svn.passwd Jan heslo
sudo htpasswd -b /etc/apache2/dav_svn.passwd Lada heslo
sudo htpasswd -b /etc/apache2/dav_svn.passwd Pavel heslo
# cat /etc/apache2/dav_svn.passwd
sudo /etc/init.d/apache2 restart
