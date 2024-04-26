cp catalogue.service /etc/systemd/system/cart.service
cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install nodejs -y
useradd roboshop
mkdir /app

curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
unzip /tmp/cart.zip
npm install

systemctl daemon-reload
systemctl enable cart
systemctl start cart
