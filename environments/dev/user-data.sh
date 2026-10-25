#!/bin/bash
set -e

# Install NGINX
dnf install -y nginx

# Get EC2 metadata using IMDSv2
TOKEN=$(curl -s -X PUT \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" \
  http://169.254.169.254/latest/api/token)

INSTANCE_ID=$(curl -s \
  -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)

PRIVATE_IP=$(curl -s \
  -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/local-ipv4)

AZ=$(curl -s \
  -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/placement/availability-zone)

HOSTNAME=$(hostname)

cat > /usr/share/nginx/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Shubham's Cloud Operations Center</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #0b1120;
            color: white;
            text-align: center;
        }

        .header {
            padding: 45px 20px 20px;
        }

        h1 {
            font-size: 42px;
            margin-bottom: 10px;
        }

        .subtitle {
            color: #94a3b8;
            font-size: 18px;
        }

        .status {
            display: inline-block;
            margin: 25px;
            padding: 10px 22px;
            background: #064e3b;
            color: #6ee7b7;
            border-radius: 20px;
            font-weight: bold;
        }

        .container {
            max-width: 900px;
            margin: auto;
            padding: 20px;
        }

        .cards {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .card {
            background: #111827;
            border: 1px solid #1e293b;
            border-radius: 12px;
            padding: 20px;
            width: 220px;
        }

        .card h3 {
            color: #38bdf8;
            margin-bottom: 8px;
        }

        .server {
            margin-top: 30px;
            background: #111827;
            border: 1px solid #38bdf8;
            border-radius: 15px;
            padding: 25px;
        }

        .server h2 {
            color: #38bdf8;
        }

        .details {
            line-height: 2;
            font-size: 17px;
        }

        .footer {
            margin-top: 40px;
            padding: 25px;
            color: #64748b;
        }

        .cloud {
            font-size: 55px;
        }
    </style>
</head>

<body>

<div class="header">

    <div class="cloud">☁</div>

    <h1>Shubham's Cloud Operations Center</h1>

    <div class="subtitle">
        Powered by Terraform & AWS
    </div>

    <div class="status">
        ● ALL SYSTEMS OPERATIONAL
    </div>

</div>


<div class="container">

    <div class="cards">

        <div class="card">
            <h3>AWS Region</h3>
            <p>ap-south-1</p>
        </div>

        <div class="card">
            <h3>Environment</h3>
            <p>DEV</p>
        </div>

        <div class="card">
            <h3>Web Server</h3>
            <p>NGINX</p>
        </div>

    </div>


    <div class="server">

        <h2>🚀 Request Served By</h2>

        <div class="details">

            <strong>Instance ID:</strong>
            $INSTANCE_ID

            <br>

            <strong>Private IP:</strong>
            $PRIVATE_IP

            <br>

            <strong>Availability Zone:</strong>
            $AZ

            <br>

            <strong>Hostname:</strong>
            $HOSTNAME

        </div>

    </div>

</div>


<div class="footer">

    Terraform • AWS • Auto Scaling • ALB • GitHub Actions

    <br><br>

    Built by Shubham ☁

</div>

</body>
</html>
EOF


systemctl enable nginx
systemctl start nginx