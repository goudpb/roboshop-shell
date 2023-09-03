cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y
#update listener address 127.0.0.0 to 0.0.0.0
systemctl enable mongod
systemctl restart mongod