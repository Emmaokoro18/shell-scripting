echo -e "\e[34m>>>>>>>>>>> Disable existing Mysql <<<<<<<<<<<<\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Install Mysql repo <<<<<<<<<<<<\e[0m"
cp Mysql.service /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Install Mysql client <<<<<<<<<<<<\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Create Password <<<<<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Set User App <<<<<<<<<<<<\e[0m"
mysql -uroot -pRoboShop@1 &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Start Mysql <<<<<<<<<<<<\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl start mysqld &>>/tmp/roboshop.log

