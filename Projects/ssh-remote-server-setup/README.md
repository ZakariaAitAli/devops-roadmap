# SSH Remote Server Setup

## 🚀 Project Overview

This project demonstrates how to set up a **remote Linux server on AWS EC2** and configure it to allow **SSH access using two different SSH key pairs**. It also includes SSH config setup for simplified access and optional hardening using **Fail2Ban**.

## 🛠 Requirements

* Launch a **remote EC2 instance** (Amazon Linux 2023 or Ubuntu).
* Generate and configure **two SSH key pairs** on your local machine.
* Add both public keys to the EC2 instance's `~/.ssh/authorized_keys` file.
* Connect to the server using both keys:

  ```bash
  ssh -i <path-to-private-key> ec2-user@<ec2-public-ip>
  ```
* Set up your `~/.ssh/config` to simplify SSH commands:

  ```bash
  ssh remote-server
  ```

## 🎯 Stretch Goals

* Install and configure **Fail2Ban** to prevent SSH brute-force attacks:

  ```bash
  sudo yum install epel-release -y
  sudo yum install fail2ban -y
  sudo systemctl enable fail2ban
  sudo systemctl start fail2ban
  ```

## 📚 Key Concepts Learned

* **Amazon EC2 instance creation and configuration**
* **SSH key pair generation and usage**
* **Public key authentication**
* **SSH configuration with `~/.ssh/config`**
* **Basic Linux hardening with Fail2Ban**

For more details, check out: [SSH Remote Server Setup Project](https://roadmap.sh/projects/ssh-remote-server-setup)
