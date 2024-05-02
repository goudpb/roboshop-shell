
cp catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[36m>>>>>>>>>>>>>>> Create mongodb <<<<<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

yum module disable nodejs -y
yum module enable nodejs:18 -y

echo "\e[36m>>>>>>>>>>>>>>> Install Node JS <<<<<<<<<<<<<<\e[0m"
yum install nodejs -y

echo "\e[36m>>>>>>>>>>>>>>> Create Application user <<<<<<<<<<<<<<\e[0m"
useradd roboshop

echo "\e[36m>>>>>>>>>>>>>>> Create Application Directory <<<<<<<<<<<<<<\e[0m"
mkdir /app

echo "\e[36m>>>>>>>>>>>>>>> Download Application Content <<<<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo "\e[36m>>>>>>>>>>>>>>> Extract Application Content <<<<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip
cd /app

echo "\e[36m>>>>>>>>>>>>>>> Download Node JS Dependencies <<<<<<<<<<<<<<\e[0m"
npm install

echo "\e[32m>>>>>>>>>>>>>>> Install Mongo client <<<<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo "\e[31m>>>>>>>>>>>>>>> Load Catalogue Schema <<<<<<<<<<<<<<"
mongo --host  mongodb.devopsb74.shop </app/schema/catalogue.js

echo "\e[31m>>>>>>>>>>>>>>> Start Catalogue Services <<<<<<<<<<<<<<"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue