yum module disable mysql -y

cp Mysql.service /etc/yum.repos.d/mysql.repo

yum install mysql-community-server -y


mysql_secure_installation --set-root-pass RoboShop@1

systemctl enable mysqld
systemctl start mysqld

mysql -uroot -pRoboShop@1