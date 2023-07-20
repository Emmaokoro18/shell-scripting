yum install nginx -y


rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

cp Frontend.service /etc/nginx/default.d/roboshop.conf

systemctl enable nginx
systemctl restart nginx

