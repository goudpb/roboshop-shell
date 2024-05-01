cp  user.service /etc/systemd/system/user.service
cp mongo.repo /etc/yum.repos.d/mongo.repo

yum module disable nodejs -y
yum module enable nodejs:18 -y

yum install nodejs -y
useradd roboshop
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip
npm install
yum install mongodb-org-shell -y
mongo --host  mongodb.devopsb74.shop </app/schema/user.js
systemctl daemon-reload
systemctl enable user
systemctl restart user