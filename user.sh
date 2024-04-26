cp catalogue.service /etc/systemd/system/user.service
cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install nodejs -y
useradd roboshop
mkdir /app

curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip
npm install

yum install mongodb-org-shell -y
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js

systemctl daemon-reload
systemctl enable user
systemctl start user
