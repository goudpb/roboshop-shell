
cp catalogue.service /etc/systemd/system/catalogue.service
echo ">>>>>>>>>>>>>>> Create mongodb <<<<<<<<<<<<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo

yum module disable nodejs -y
yum module enable nodejs:18 -y

echo ">>>>>>>>>>>>>>> Install Node JS <<<<<<<<<<<<<<"
yum install nodejs -y

echo ">>>>>>>>>>>>>>> Create Application user <<<<<<<<<<<<<<"
useradd roboshop

echo ">>>>>>>>>>>>>>> Create Application Directory <<<<<<<<<<<<<<"
mkdir /app

echo ">>>>>>>>>>>>>>> Download Application Content <<<<<<<<<<<<<<"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo ">>>>>>>>>>>>>>> Extract Application Content <<<<<<<<<<<<<<"
cd /app
unzip /tmp/catalogue.zip
cd /app

echo ">>>>>>>>>>>>>>> Download Node JS Dependencies <<<<<<<<<<<<<<"
npm install
echo ">>>>>>>>>>>>>>> Install Mongo client <<<<<<<<<<<<<<"
yum install mongodb-org-shell -y

echo ">>>>>>>>>>>>>>> Load Catalogue Schema <<<<<<<<<<<<<<"
mongo --host  mongodb.devopsb74.shop </app/schema/catalogue.js

echo ">>>>>>>>>>>>>>> Start Catalogue Services <<<<<<<<<<<<<<"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue