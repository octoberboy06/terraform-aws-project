#!/bin/bash
set -e

dnf install -y nginx

echo "<h1>Terraform AWS Project</h1>" > /usr/share/nginx/html/index.html
echo "<p>Deployed using Terraform + Auto Scaling</p>" >> /usr/share/nginx/html/index.html

systemctl enable nginx
systemctl start nginx