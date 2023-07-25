echo echo ">>>>>>>>>>> Create Catalogue Service <<<<<<<<<<<<"
cp Catalogue.service /etc/systemd/system/catalogue.service
echo ">>>>>>>>>>> Create MongoDB Repo/Service <<<<<<<<<<<<"
cp Mongo.service /etc/yum.repos.d/mongo.repo

echo ">>>>>>>>>>> Install NodeJS repos  <<<<<<<<<<<<"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo ">>>>>>>>>>> Install NodeJS <<<<<<<<<<<<"
yum install nodejs -y

echo ">>>>>>>>>>> Create Application User <<<<<<<<<<<<"
useradd roboshop

echo ">>>>>>>>>>> Make App Directory <<<<<<<<<<<<"
mkdir /app

echo ">>>>>>>>>>> Download Application Content <<<<<<<<<<<<"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo ">>>>>>>>>>> Unzip Application Content <<<<<<<<<<<<"
cd /app
unzip /tmp/catalogue.zip

echo ">>>>>>>>>>> Install NodeJS Dependencies <<<<<<<<<<<<"
cd /app
npm install

echo ">>>>>>>>>>> Install Mongo client <<<<<<<<<<<<"
yum install mongodb-org-shell -y

echo ">>>>>>>>>>> Load Catalogue Schema <<<<<<<<<<<<"
mongo --host mongodb.bigetech.online </app/schema/catalogue.js

echo ">>>>>>>>>>> Start Catalogue Service <<<<<<<<<<<<"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue