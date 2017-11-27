#!/bin/bash
echo "**** Installing prerequisite ****"
yum -y install epel-release
yum -y install python-pip 2> /dev/null
pip install Flask  2> /dev/null
yum -y install python-memcached

echo "**** Installing Apache ****"
yum -y install httpd

echo "**** Reconfigure apache with SSL ****"
yum -y install mod_ssl
       
echo "**** Configuring httpd to redirect HTTP links to HTTPS ****"
if grep "http-to-https-redirection" /etc/httpd/conf/httpd.conf &> /dev/null
then
echo "Already redirecting http to https"
else
echo '''
#### http-to-https-redirection ####
RewriteEngine On 
RewriteCond %{HTTPS}  !=on 
RewriteRule ^/?(.*) https://%{SERVER_NAME}:8443/$1 [R,L]
''' >> /etc/httpd/conf/httpd.conf
fi

echo "**** Configuring Apache to run my flask app ****"
yum -y install mod_wsgi
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/sysconfig/selinux
setenforce 0
if grep "settings-for-my-app" /etc/httpd/conf/httpd.conf &> /dev/null 
then
echo "My app is already configured"
else
echo '''
#### settings-for-my-app ####
WSGIDaemonProcess app threads=5
WSGIScriptAlias /app /var/www/html/app/app.wsgi

<Directory /var/www/html/app>
    WSGIProcessGroup app
    WSGIApplicationGroup %{GLOBAL}
    WSGIScriptReloading On
    Order deny,allow
    Allow from all
</Directory>
WSGISocketPrefix /tmp/akshay
''' >> /etc/httpd/conf/httpd.conf
fi

echo "**** Starting Apache service ****"
chkconfig httpd on
service httpd start 2> /dev/null

echo "**** Ensuring apache is running ****"
service httpd status

echo "**** Installing my flask app ****"
tar xzf /vagrant/my_app-v01.tar.gz -C /var/www/html/

echo "**** Installing Memcached ****"
yum -y install memcached

echo "**** Starting Memcached service ****"
chkconfig memcached on
service memcached start

echo "**** Ensuring Memcached is running ****"
service memcached status

echo "**** Write / Read some random data to memcache ****"
yum -y install nc
bash /vagrant/akshay_read_write_random_data_to_memcache_script.sh &> /dev/null

echo "**** Adding cronjob that runs /home/vagrant/exercise-memcached.sh once per minute ****"
cp -f /vagrant/exercise-memcached.sh /home/vagrant/exercise-memcached.sh
chmod a+x /home/vagrant/exercise-memcached.sh
( crontab -l 2> /dev/null ; echo "* * * * * /home/vagrant/exercise-memcached.sh") | crontab -

echo "**** Provisioner ends here ****"
