cp  catalogue.service /etc/systemd/system/catalogue.
cp mongo.repo /etc/yum.repos.d/mongo.repo

yum module disable nodejs -y
yum module enable nodejs:18 -y

yum install nodejs -y
useradd roboshop
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
npm install
yum install mongodb-org-shell -y
mongo --host  mongodb.devopsb74.shop </app/schema/catalogue.js
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue