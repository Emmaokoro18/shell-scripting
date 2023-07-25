echo -e "\e[34m>>>>>>>>>>> Install NodeJS repo <<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Install NodeJS <<<<<<<<<<<<\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Create App User <<<<<<<<<<<<\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Delete existing Service App <<<<<<<<<<<<\e[0m"
rm -rf /app &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Create Service App <<<<<<<<<<<<\e[0m"
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Download App Content <<<<<<<<<<<<\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Extract App Content <<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/user.zip &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Install NOdeJS Dependencies <<<<<<<<<<<<\e[0m"
cd /app
npm install &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Create User System service <<<<<<<<<<<<\e[0m"
cp User.service /etc/systemd/system/user.service &>>/tmp/roboshop.log


echo -e "\e[34m>>>>>>>>>>> Install Mongo Repo <<<<<<<<<<<<\e[0m"
cp Mongo.service /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Install MongoDB client <<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Load Schema <<<<<<<<<<<<\e[0m"
mongo --host mongodb.bigetech.online </app/schema/user.js &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Start User <<<<<<<<<<<<\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable user &>>/tmp/roboshop.log
systemctl restart user &>>/tmp/roboshop.log