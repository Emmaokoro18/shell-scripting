echo -e "\e[34m>>>>>>>>>>> Create Catalogue Service <<<<<<<<<<<<\e[0m"
cp Catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[34m>>>>>>>>>>> Create MongoDB Repo/Service <<<<<<<<<<<<\e[0m"
cp Mongo.service /etc/yum.repos.d/mongo.repo

echo -e "\e[34m>>>>>>>>>>> Install NodeJS repos  <<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[34m>>>>>>>>>>> Install NodeJS <<<<<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[34m>>>>>>>>>>> Create Application User <<<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[34m>>>>>>>>>>> Make App Directory <<<<<<<<<<<<\e[0m"
mkdir /app

echo -e "\e[34m>>>>>>>>>>> Download Application Content <<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[34m>>>>>>>>>>> Unzip Application Content <<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip

echo -e "\e[34m>>>>>>>>>>> Install NodeJS Dependencies <<<<<<<<<<<<\e[0m"
cd /app
npm install

echo -e "\e[34m>>>>>>>>>>> Install Mongo client <<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[34m>>>>>>>>>>> Load Catalogue Schema <<<<<<<<<<<<\e[0m"
mongo --host mongodb.bigetech.online </app/schema/catalogue.js

echo -e "\e[34m>>>>>>>>>>> Start Catalogue Service <<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue