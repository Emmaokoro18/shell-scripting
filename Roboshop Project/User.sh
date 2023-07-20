curl -sL https://rpm.nodesource.com/setup_lts.x | bash

yum install nodejs -y

useradd roboshop
mkdir /app

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip

cd /app
npm install

cp User.service /etc/systemd/system/user.service

systemctl daemon-reload

cp Mongo.service /etc/yum.repos.d/mongo.repo

yum install mongodb-org-shell -y

mongo --host mongodb.bigetech.online </app/schema/user.js

systemctl enable user
systemctl restart user