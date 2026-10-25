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

# Create Cloud Operations Center webpage
cat > /usr/share/nginx/html/index.html <<EOF
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Shubham's Cloud Operations Center</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #0b1120;
            color: white;
            text-align: center;
        }

        .header {
            padding: 45px 20px 20px;
        }

        .cloud {
            font-size: 55px;
            margin-bottom: 10px;
        }

        h1 {
            font-size: 42px;
            margin: 10px 0;
        }

        .subtitle {
            color: #94a3b8;
            font-size: 18px;
            margin-top: 10px;
        }

        .status {
            display: inline-block;
            margin: 25px;
            padding: 12px 24px;
            background: #064e3b;
            color: #6ee7b7;
            border-radius: 25px;
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
            margin-top: 0;
            margin-bottom: 8px;
        }

        .card p {
            margin-bottom: 0;
            font-size: 17px;
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
            margin-top: 0;
        }

        .details {
            line-height: 2.2;
            font-size: 17px;
        }

        .value {
            color: #6ee7b7;
            font-family: monospace;
            font-size: 16px;
        }

        .footer {
            margin-top: 40px;
            padding: 25px;
            color: #64748b;
        }

        .footer-tech {
            color: #94a3b8;
        }

    </style>

</head>

<body>

    <div class="header">

        <div class="cloud">&#9729;</div>

        <h1>Shubham's Cloud Operations Center</h1>

        <div class="subtitle">
            Powered by Terraform &amp; AWS
        </div>

        <div class="status">
            &#9679; ALL SYSTEMS OPERATIONAL
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

            <h2>&#128640; Request Served By</h2>

            <div class="details">

                <strong>Instance ID:</strong>
                <span class="value">$INSTANCE_ID</span>

                <br>

                <strong>Private IP:</strong>
                <span class="value">$PRIVATE_IP</span>

                <br>

                <strong>Availability Zone:</strong>
                <span class="value">$AZ</span>

                <br>

                <strong>Hostname:</strong>
                <span class="value">$HOSTNAME</span>

            </div>

        </div>

    </div>


    <div class="footer">

        <div class="footer-tech">
            Terraform &bull; AWS &bull; Auto Scaling &bull; ALB &bull; GitHub Actions
        </div>

        <br>

        Built by Shubham &#9729;

    </div>

</body>

</html>
EOF

# Enable and start NGINX
systemctl enable nginx
systemctl start nginx