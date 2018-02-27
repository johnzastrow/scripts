#!/bin/sh
echo ""
        time find /var/www/html/ -type l -print > websymbolic.list
        echo ""
        echo "excluding the following files from the web tar"
        echo "**********************************************"
        cat websymbolic.list
        echo ""
        echo "making web tar"
        time tar --exclude-from=websymbolic.list -czf web_dater.tar.gz /var/www/html/*

