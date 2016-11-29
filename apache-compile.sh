#!/bin/sh
# This is pseudo script to download and install apache and php
# DO NOT TRY TO RUN IT. JUST RUN THROUGH THE PROCESS MANUALLY
#
wget http://apache.mirrors.redwire.net/httpd/httpd-2.2.6.tar.gz

# or lynx http://httpd.apache.org/download.cgi
gzip -d httpd-2.2.4.tar.gz
tar xvf httpd-2.2.4.tar.gz
cd httpd-2.2.4
./configure --prefix=/usr/local/apache2 \
--enable-dav=shared \
--enable-dav_fs=shared \
--enable-dav_lock=shared \
--enable-imagemap=shared \
--enable-speling=shared \
--enable-ssl=shared \
--enable-status=shared \
--enable-userdir=shared \
--enable-usertrack=shared \
--enable-cache \


make
make install
/usr/local/apache2/bin/apachectl -k start

# Build and install apr 1.2
cd srclib/apr
./configure --prefix=/usr/local/apr-httpd

cd ../../
./configure --prefix=/usr/local/apache2 \
--enable-dav=shared \
--enable-dav_fs=shared \
--enable-dav_lock=shared \
--enable-imagemap=shared \
--enable-speling=shared \
--enable-ssl=shared \
--enable-status=shared \
--enable-userdir=shared \
--enable-usertrack=shared \
--enable-cache \
--with-apr=/usr/local/apr-httpd --with-apr-util=/usr/local/apr-util
make
make install

# Build and install apr-util 1.2
cd ../apr-util
./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr-httpd
make
make install

# Configure httpd
cd ../../
./configure --with-apr=/usr/local/apr-httpd/ --with-apr-util=/usr/local/apr-util-httpd/

wget http://us2.php.net/get/php-5.2.3.tar.gz/from/www.php.net/mirror

/usr/local/apache2/bin/apachectl stop
cd php-5.2.3
./configure \
--with-apxs2=/usr/local/apache2/bin/apxs \
--with-mysql \
--enable-exif \
--with-gd=/usr/local/bin \
--with-jpeg-dir[=DIR] \
--with-png-dir[=DIR] \
--with-zlib-dir[=DIR] \ 
 --with-freetype-dir[=DIR] \
--with-gettext[=DIR] \
--with-mysqli[=FILE] \
--with-oci8[=DIR] \
--with-pdo-oci[=DIR] \
--with-readline[=DIR] \
--enable-soap \
--enable-wddx




cp php.ini-dist /usr/local/lib/php.ini
edit httpd.conf
LoadModule php5_module modules/libphp5.so
AddType application/x-httpd-php .php .phtml
AddType application/x-httpd-php-source .phps

