cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y
#update local IP
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
systemctl enable mongod
systemctl restart mongod