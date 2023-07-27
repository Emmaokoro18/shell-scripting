nodejs() {
  log=/tmp/roboshop.log
  echo -e "\e[34m>>>>>>>>>>> Create User System service <<<<<<<<<<<<\e[0m"
  cp ${component}.service /etc/systemd/system/${component}.service &>>${log}

  echo -e "\e[34m>>>>>>>>>>> Install Mongo Repo <<<<<<<<<<<<\e[0m"
  cp Mongo.service /etc/yum.repos.d/mongo.repo &>>${log}

  echo -e "\e[34m>>>>>>>>>>> Install NodeJS repo <<<<<<<<<<<<\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}

  echo -e "\e[34m>>>>>>>>>>> Install NodeJS <<<<<<<<<<<<\e[0m"
  yum install nodejs -y &>>${log}

  echo -e "\e[34m>>>>>>>>>>> Create App User <<<<<<<<<<<<\e[0m"
  useradd roboshop &>>${log}

  echo -e "\e[34m>>>>>>>>>>> Delete existing Service App <<<<<<<<<<<<\e[0m"
  rm -rf /app &>>${log}

  echo -e "\e[34m>>>>>>>>>>> Create Service App <<<<<<<<<<<<\e[0m"
  mkdir /app &>>${log}

  echo -e "\e[34m>>>>>>>>>>> Download App Content <<<<<<<<<<<<\e[0m"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}

  echo -e "\e[34m>>>>>>>>>>> Extract App Content <<<<<<<<<<<<\e[0m"
  cd /app
  unzip /tmp/${component}.zip &>>${log}

  echo -e "\e[34m>>>>>>>>>>> Install NOdeJS Dependencies <<<<<<<<<<<<\e[0m"
  cd /app
  npm install &>>${log}

  func_schema_setup


  echo -e "\e[34m>>>>>>>>>>> Start User <<<<<<<<<<<<\e[0m"
  systemctl daemon-reload &>>${log}
  systemctl enable ${component} &>>${log}
  systemctl restart ${component} &>>${log}
}

func_schema_setup() {
  if [ "${schema_type}" == "mongodb" ]
  then
      echo -e "\e[34m>>>>>>>>>>> Install MongoDB client <<<<<<<<<<<<\e[0m"
      yum install mongodb-org-shell -y &>>${log}

      echo -e "\e[34m>>>>>>>>>>> Load Schema <<<<<<<<<<<<\e[0m"
      mongo --host mongodb.bigetech.online </app/schema/${component}.js &>>${log}
  fi
}