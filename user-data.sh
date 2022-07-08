#!/bin/bash
yum install httpd -y
cd /var/www/html
ec2_private_ip=$(hostname -I)
echo "<html><body> Welcome! the private IP adress of the running instance is $ec2_private_ip </body></html>" >> index.html
service httpd start
chkconfig httpd on
