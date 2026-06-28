# SSH Remote Server Setup

Configures an AWS EC2 instance for SSH access using two separate key pairs, hardens the SSH daemon, and installs Fail2Ban to protect against brute-force attacks.

## Requirements

- An AWS EC2 instance (Amazon Linux 2023 or Ubuntu)
- Two SSH key pairs generated locally
- SSH client on your local machine

## Setup

### 1. Generate two key pairs locally

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_key1 -C "key1"
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_key2 -C "key2"
```

### 2. Run the setup script on the remote server

Copy both public keys to the server and run the script:

```bash
scp ~/.ssh/id_ed25519_key1.pub ~/.ssh/id_ed25519_key2.pub ec2-user@<EC2-PUBLIC-IP>:~/
ssh -i <original-key.pem> ec2-user@<EC2-PUBLIC-IP> \
  'bash -s' < setup.sh id_ed25519_key1.pub id_ed25519_key2.pub
```

The script:
1. Appends both public keys to `~/.ssh/authorized_keys`
2. Disables root login and password authentication via `/etc/ssh/sshd_config.d/hardening.conf`
3. Restarts `sshd`
4. Installs and enables Fail2Ban

### 3. Configure `~/.ssh/config` locally

Add entries to `~/.ssh/config` so you can connect without specifying the key each time:

```
Host ec2-key1
  HostName <EC2-PUBLIC-IP>
  User ec2-user
  IdentityFile ~/.ssh/id_ed25519_key1

Host ec2-key2
  HostName <EC2-PUBLIC-IP>
  User ec2-user
  IdentityFile ~/.ssh/id_ed25519_key2
```

### 4. Connect

```bash
ssh ec2-key1
ssh ec2-key2
```

Both should connect successfully before you close your original session.

## Security Hardening Applied

| Setting | Value | Reason |
|---------|-------|--------|
| `PermitRootLogin` | `no` | Eliminates direct root access |
| `PasswordAuthentication` | `no` | Forces key-based auth only |
| Fail2Ban | enabled | Bans IPs after repeated failed SSH attempts |

## Files

```
05-ssh-remote-server-setup/
  setup.sh     Automates key authorization, SSH hardening, and Fail2Ban installation
  README.md
```

## Reference

[roadmap.sh — SSH Remote Server Setup](https://roadmap.sh/projects/ssh-remote-server-setup)
