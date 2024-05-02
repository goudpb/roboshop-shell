
echo -e "\e[36m>>>>>>>>>>>>>>> Create Catalogue Service <<<<<<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service >/tmp/roboshop.log

echo -e "\e[36m>>>>>>>>>>>>>>> Create mongodb <<<<<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo >/tmp/roboshop.log

yum module disable nodejs -y >/tmp/roboshop.log
yum module enable nodejs:18 -y >/tmp/roboshop.log

echo -e  "\e[36m>>>>>>>>>>>>>>> Install Node JS <<<<<<<<<<<<<<\e[0m"
yum install nodejs -y >/tmp/roboshop.log

echo -e "\e[36m>>>>>>>>>>>>>>> Create Application user <<<<<<<<<<<<<<\e[0m"
useradd roboshop >/tmp/roboshop.log

echo -e "\e[36m>>>>>>>>>>>>>>> Remove Application Directory <<<<<<<<<<<<<<\e[0m"
rm -rf /app >/tmp/roboshop.log

echo -e "\e[36m>>>>>>>>>>>>>>> Create Application Directory <<<<<<<<<<<<<<\e[0m"
mkdir /app >/tmp/roboshop.log

echo -e "\e[36m>>>>>>>>>>>>>>> Download Application Content <<<<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip >/tmp/roboshop.log

echo -e "\e[36m>>>>>>>>>>>>>>> Extract Application Content <<<<<<<<<<<<<<\e[0m" >/tmp/roboshop.log
cd /app >/tmp/roboshop.log
unzip /tmp/catalogue.zip >/tmp/roboshop.log
cd /app >/tmp/roboshop.log

echo -e "\e[36m>>>>>>>>>>>>>>> Download Node JS Dependencies <<<<<<<<<<<<<<\e[0m"
npm install >/tmp/roboshop.log

echo -e "\e[32m>>>>>>>>>>>>>>> Install Mongo client <<<<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y >/tmp/roboshop.log

echo -e "\e[31m>>>>>>>>>>>>>>> Load Catalogue Schema <<<<<<<<<<<<<<"
mongo --host  mongodb.devopsb74.shop </app/schema/catalogue.js >/tmp/roboshop.log

echo "\e[31m>>>>>>>>>>>>>>> Start Catalogue Services <<<<<<<<<<<<<<"
systemctl daemon-reload >/tmp/roboshop.log
systemctl enable catalogue >/tmp/roboshop.log
systemctl restart catalogue >/tmp/roboshop.log