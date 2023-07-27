echo -e "\e[34m>>>>>>>>>>> Create Shipping System service <<<<<<<<<<<<\e[0m"
cp Shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Install Maven <<<<<<<<<<<<\e[0m"
yum install maven -y &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Create App User <<<<<<<<<<<<\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Remove App Directory <<<<<<<<<<<<\e[0m"
rm -rf /app &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Create App Directory <<<<<<<<<<<<\e[0m"
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Download Roboshop content <<<<<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Extract Roboshop content <<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Download Dependencies <<<<<<<<<<<<\e[0m"
cd /app
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log



echo -e "\e[34m>>>>>>>>>>> Install Msql <<<<<<<<<<<<\e[0m"
yum install mysql -y &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Load Schema <<<<<<<<<<<<\e[0m"
mysql -h mysql.bigetech.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Start System <<<<<<<<<<<<\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log


