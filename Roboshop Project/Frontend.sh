echo -e "\e[34m>>>>>>>>>>> Install NGINX <<<<<<<<<<<<\e[0m"
yum install nginx -y &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Create Frontend Services <<<<<<<<<<<<\e[0m"
cp Frontend.service /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Delete existing Nginx content <<<<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Download Application Content <<<<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Extract App content <<<<<<<<<<<<\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log


echo -e "\e[34m>>>>>>>>>>> Start Frontend <<<<<<<<<<<<\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log

