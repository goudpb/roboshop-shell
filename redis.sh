yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
yum module enable redis:remi-6.2 -y
yum install redis -y
#update local host
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
systemctl enable redis
systemctl restart redis
