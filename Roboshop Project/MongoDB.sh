echo -e "\e[34m>>>>>>>>>>> Install MongoDB Repo <<<<<<<<<<<<\e[0m"
cp Mongo.service /etc/yum.repos.d/mongo.repo &>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Install MongoDB <<<<<<<<<<<<\e[0m"
yum install mongodb-org -y &>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Replace mongo.conf <<<<<<<<<<<<\e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>/tmp/roboshop.log

echo -e "\e[34m>>>>>>>>>>> Start MongoDB <<<<<<<<<<<<\e[0m"
systemctl enable mongod &>/tmp/roboshop.log
systemctl restart mongod &>/tmp/roboshop.log