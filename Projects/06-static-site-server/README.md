# Static Site Server with AWS + Nginx

This project demonstrates how to set up a **basic Linux server on AWS** and configure it to serve a **static website using Nginx**. It also includes an automated deployment workflow using **rsync** and a `deploy.sh` script.

The goal is to understand:

* Provisioning and connecting to a Linux server (EC2)
* Installing and configuring **Nginx** on Amazon Linux 2023
* Serving static files from `/var/www/static-site`
* Deploying updates from a local machine using **rsync**
* (Optional) Connecting a **domain name** to the server

---

## 🚀 Architecture

```
Local Machine ──(rsync/ssh)──▶ AWS EC2 Instance ──▶ Nginx ──▶ Browser
```

---

## 🛠️ Requirements

* **AWS Account** (Free tier available)
* **Amazon Linux 2023 EC2 instance**
* **SSH key pair (.pem file)**
* **Nginx** installed on the server
* **rsync** installed locally
* (Optional) Domain name pointing to your EC2’s public IP

---

## ⚙️ Setup Steps

### 1. Launch an EC2 Instance

1. Go to the **AWS Management Console**
2. Create a new **EC2 instance**:

   * Amazon Linux 2023
   * t2.micro (free tier eligible)
   * Allow **SSH (22)** and **HTTP (80)** in security group
3. Download and save your **.pem key**
4. Connect via SSH:

```bash
ssh -i personal.pem ec2-user@<EC2_PUBLIC_IP>
```

---

### 2. Install Nginx

Amazon Linux 2023 uses `yum` instead of `apt`.

```bash
# Update packages
sudo yum update -y

# Install nginx
sudo yum install nginx -y

# Enable and start nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Verify status
systemctl status nginx
```

Visit `http://<EC2_PUBLIC_IP>` and you should see the default Nginx welcome page ✅.

---

### 3. Configure Nginx for the Static Site

1. Create the web root:

```bash
sudo mkdir -p /var/www/static-site
sudo chown -R $USER:$USER /var/www/static-site
```

2. Create a new server block in `/etc/nginx/conf.d/`:

```bash
sudo nano /etc/nginx/conf.d/static-site.conf
```

Paste:

```nginx
server {
    listen 80;
    server_name _;

    root /var/www/static-site;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

3. Test and reload:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

---

### 4. Build a Simple Static Site

Local project structure:

```
static-site/
├── index.html
├── styles.css
└── images/
    └── aws.png
```

Example `index.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Static Site on AWS</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Hello from AWS + Nginx 🎉</h1>
    <p>This site is served from an EC2 instance running Amazon Linux 2023.</p>
    <img src="images/aws.png" alt="AWS Logo">
</body>
</html>
```

---

### 5. Deploy with rsync

Create `deploy.sh`:

```bash
#!/bin/bash

USER=ec2-user
HOST=<EC2_PUBLIC_IP>
KEY=~/Projects/personal.pem
SOURCE=./static-site/
TARGET=/var/www/static-site/

echo "🚀 Deploying to $USER@$HOST ..."
rsync -avz -e "ssh -i $KEY" $SOURCE $USER@$HOST:$TARGET
echo "✅ Deployment complete! Visit http://$HOST"
```

Make it executable:

```bash
chmod +x deploy.sh
```

Run deployment:

```bash
./deploy.sh
```

Now refresh `http://<EC2_PUBLIC_IP>` → your static site is live 🎉.

---

### 6. (Optional) Domain Setup

If you own a domain:

1. Add an **A record** pointing to your EC2 public IP
2. Update `server_name` in `/etc/nginx/conf.d/static-site.conf`:

```nginx
server {
    listen 80;
    server_name example.com www.example.com;
    root /var/www/static-site;
    index index.html;
    location / {
        try_files $uri $uri/ =404;
    }
}
```

3. Reload Nginx:

```bash
sudo systemctl reload nginx
```

Now your static site is live at `http://example.com`.

---

## 📂 Project Structure

```
.
├── static-site/
│   ├── index.html
│   ├── styles.css
│   └── images/
├── deploy.sh
└── README.md
```

---

## ✅ Learning Outcomes

By completing this project, you will:

* Understand how to provision and configure Amazon Linux EC2
* Serve a static site using **Nginx**
* Automate deployments with **rsync**
* Configure DNS for a custom domain
