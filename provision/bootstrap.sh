#!/bin/sh

echo_progress()
{
	echo '------------[' $1 ']------------'
}

PKG_INSTALL="pkg install -y"

# Install apache
echo_progress 'apache24'
$PKG_INSTALL apache24
cp /vagrant/provision/httpd.conf /usr/local/etc/apache24
echo apache24_enable=\"YES\" >> /etc/rc.conf

# Install sudo
echo_progress 'sudo'
$PKG_INSTALL sudo

# Install PHP
echo_progress 'php5'
$PKG_INSTALL php5
cp /usr/local/etc/php.ini-development /usr/local/etc/php.ini

# Install PHP Extensions
echo_progress 'php5-extensions'
$PKG_INSTALL php5-extensions

# Install php-zlib
echo_progress 'php5-zlib'
$PKG_INSTALL php5-zlib

# Install php-curl
echo_progress 'php5-curl'
$PKG_INSTALL php5-curl

# Install php-mcrypt
echo_progress 'php-mcrypt'
$PKG_INSTALL php5-mcrypt

# Install php-gd
echo_progress 'freetype2'
$PKG_INSTALL freetype2

# Install php-gd
echo_progress 'php5-gd'
$PKG_INSTALL php5-gd

# Install php-gd
echo_progress 'php5-openssl'
$PKG_INSTALL php5-openssl

# Install mod_php55
echo_progress 'mod_php5'
$PKG_INSTALL mod_php5

# Install MySQL 5.6
echo_progress 'mysql56-server'
$PKG_INSTALL mysql56-server
echo mysql_enable=\"YES\" >> /etc/rc.conf

# Install PHP MySQL
echo_progress 'php5-mysql'
$PKG_INSTALL php5-mysql

# Install PHP PDO MySQL
echo_progress 'php5-pdo_mysql'
$PKG_INSTALL php5-pdo_mysql

# Install wget
echo_progress 'wget'
$PKG_INSTALL wget

# Install libxml2 (Required by composer)
echo_progress 'libxml2 (Required by composer)'
$PKG_INSTALL libxml2

# Install git
echo_progress 'git'
$PKG_INSTALL git

# Configure MySQL
echo_progress 'Configuring MySQL'
cd /usr/local/share/mysql/
cp /usr/local/share/mysql/my-default.cnf /etc/my.cnf

# Start MySQL
echo_progress 'Starting MySQL'
/usr/local/etc/rc.d/mysql-server start

# Set MySQL root password to 'root'
echo_progress 'Setting MySQL root password to "root"'
mysqladmin -u root password root

# Enable MySQL remote access
echo_progress 'Enabling MySQL remote access'
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;"

# Start Apache
echo_progress 'Starting apache'
/usr/local/etc/rc.d/apache24 start
