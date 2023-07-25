echo -e "\e[34m>>>>>>>>>>> Create Catalogue Service <<<<<<<<<<<<\e[0m"
cp Catalogue.service /etc/systemd/system/catalogue.service &>/tmp/roboshop.log
echo -e "\e[34m>>>>>>>>>>> Create MongoDB Repo/Service <<<<<<<<<<<<\e[0m"
cp Mongo.service /etc/yum.repos.d/mongo.repo &>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Install NodeJS repos  <<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Install NodeJS <<<<<<<<<<<<\e[0m"
yum install nodejs -y &>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Create Application User <<<<<<<<<<<<\e[0m"
useradd roboshop &>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Delete existing App Directory <<<<<<<<<<<<\e[0m"
rm -rf /app &>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Make App Directory <<<<<<<<<<<<\e[0m"
mkdir /app &>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Download Application Content <<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Unzip Application Content <<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip &>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Install NodeJS Dependencies <<<<<<<<<<<<\e[0m"
cd /app
npm install &>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Install Mongo client <<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y &>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Load Catalogue Schema <<<<<<<<<<<<\e[0m"
mongo --host mongodb.bigetech.online </app/schema/catalogue.js &>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Start Catalogue Service <<<<<<<<<<<<\e[0m"
systemctl daemon-reload &>/tmp/roboshop.log
systemctl enable catalogue &>/tmp/roboshop.log
systemctl restart catalogue &>/tmp/roboshop.log