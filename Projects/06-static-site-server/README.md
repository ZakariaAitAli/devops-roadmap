# Static Site Server

Provisions an AWS EC2 instance, installs and configures Nginx to serve a static website, and deploys site files from a local machine using `rsync`.

## Architecture

```
Local machine  ---(rsync over SSH)--->  EC2 (Amazon Linux 2023)  --->  Nginx  --->  Browser
```

## Requirements

- AWS account (free tier eligible)
- EC2 instance running Amazon Linux 2023
- SSH key pair (`.pem` file)
- `rsync` installed locally
- Nginx installed on the server

## Server Setup

### 1. Launch an EC2 instance

- AMI: Amazon Linux 2023
- Instance type: t2.micro (free tier)
- Security group: allow inbound SSH (22) and HTTP (80)

Connect to the instance:

```bash
ssh -i ~/.ssh/your-key.pem ec2-user@<EC2-PUBLIC-IP>
```

### 2. Install Nginx

```bash
sudo yum update -y
sudo yum install nginx -y
sudo systemctl enable --now nginx
```

Verify: open `http://<EC2-PUBLIC-IP>` in a browser — you should see the Nginx default page.

### 3. Configure Nginx

Create the web root:

```bash
sudo mkdir -p /var/www/static-site
sudo chown -R ec2-user:ec2-user /var/www/static-site
```

Create a server block at `/etc/nginx/conf.d/static-site.conf`:

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

Test and reload:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

## Local Deployment

### Configure environment

Copy `.env.example` to `.env` and fill in your values:

```bash
cp .env.example .env
```

```bash
DEPLOY_USER=ec2-user
DEPLOY_HOST=<your-ec2-public-dns-or-ip>
DEPLOY_KEY=~/.ssh/your-key.pem
DEPLOY_SOURCE=./static-site/
DEPLOY_TARGET=/var/www/static-site/
```

`.env` is listed in `.gitignore` and will not be committed.

### Deploy

```bash
chmod +x deploy.sh
./deploy.sh
```

The script reads variables from `.env`, then runs:

```bash
rsync -avz -e "ssh -i $KEY" ./static-site/ ec2-user@<HOST>:/var/www/static-site/
```

`rsync` transfers only changed files, making subsequent deploys fast.

## Optional: Custom Domain

1. Add an **A record** in your DNS provider pointing to the EC2 public IP.
2. Update `server_name` in `/etc/nginx/conf.d/static-site.conf`:

```nginx
server_name example.com www.example.com;
```

3. Reload Nginx:

```bash
sudo systemctl reload nginx
```

## Files

```
06-static-site-server/
  deploy.sh             Deployment script (reads config from .env)
  .env.example          Template for required environment variables
  static-site/
    index.html
    styles.css
    images/
      aws.png
  README.md
```

## Reference

[roadmap.sh — Static Site Server](https://roadmap.sh/projects/static-site-server)
