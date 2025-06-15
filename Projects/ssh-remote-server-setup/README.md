# SSH Remote Server Setup

## 🚀 Project Overview

This project demonstrates how to **set up a remote Linux server** on **AWS EC2** and configure **SSH access** using **two different key pairs**. The setup also includes simplifying the connection using the `~/.ssh/config` file.

## 🛠 Requirements

* A **remote EC2 instance** (Amazon Linux 2023).

* Two **SSH key pairs** generated locally:

  ```bash
  ssh-keygen -t rsa -f ~/.ssh/id_rsa_key1
  ssh-keygen -t rsa -f ~/.ssh/id_rsa_key2
  ```

* Both public keys added to the server’s `~/.ssh/authorized_keys` file:

  ```bash
  cat ~/.ssh/id_rsa_key1.pub >> ~/.ssh/authorized_keys
  cat ~/.ssh/id_rsa_key2.pub >> ~/.ssh/authorized_keys
  ```

* SSH access should work with both private keys:

  ```bash
  ssh -i ~/.ssh/id_rsa_key1 ec2-user@<EC2-PUBLIC-IP>
  ssh -i ~/.ssh/id_rsa_key2 ec2-user@<EC2-PUBLIC-IP>
  ```

* A configured `~/.ssh/config` file to allow simplified connections:

  ```bash
  # ~/.ssh/config

  Host remote-server-key1
    HostName <EC2-PUBLIC-IP>
    User ec2-user
    IdentityFile ~/.ssh/id_rsa_key1

  Host remote-server-key2
    HostName <EC2-PUBLIC-IP>
    User ec2-user
    IdentityFile ~/.ssh/id_rsa_key2
  ```

* You can now connect using simple commands:

  ```bash
  ssh remote-server-key1
  ssh remote-server-key2
  ```

## 🎯 Stretch Goals

* Install and configure **Fail2Ban** to protect the server from SSH brute-force attacks:

  ```bash
  sudo yum install epel-release -y
  sudo yum install fail2ban -y
  sudo systemctl enable fail2ban
  sudo systemctl start fail2ban
  ```

## 📚 Key Concepts Learned

* **EC2 Instance Setup on AWS**
* **SSH Key Generation and Configuration**
* **Managing Multiple SSH Keys**
* **Simplifying Access with `~/.ssh/config`**
* **Basic Linux Hardening with Fail2Ban**

For more details, check out: [SSH Remote Server Setup Project](https://roadmap.sh/projects/ssh-remote-server-setup)
