#! /bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo systemctl start nginx.service
# sudo service httpd start  
sudo echo '<h1>Welcome to my page  - APP-1</h1>' | sudo tee /var/www/html/index.html  
sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/metadata.html
