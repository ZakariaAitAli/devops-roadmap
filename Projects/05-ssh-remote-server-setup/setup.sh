#!/bin/bash

# Run this script on the remote EC2 instance after first login:
#   ssh -i <key.pem> ec2-user@<EC2-PUBLIC-IP> 'bash -s' < setup.sh
#
# Or copy it to the server and run it there:
#   scp setup.sh ec2-user@<EC2-PUBLIC-IP>:~/ && ssh ec2-user@<EC2-PUBLIC-IP> 'bash setup.sh'

set -e

KEY1_PUB=${1:?Usage: $0 <path-to-key1.pub> <path-to-key2.pub>}
KEY2_PUB=${2:?Usage: $0 <path-to-key1.pub> <path-to-key2.pub>}

echo "[1/3] Authorizing SSH keys..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cat "$KEY1_PUB" >> ~/.ssh/authorized_keys
cat "$KEY2_PUB" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
echo "  Both public keys added to ~/.ssh/authorized_keys"

echo "[2/3] Hardening SSH config..."
sudo tee /etc/ssh/sshd_config.d/hardening.conf > /dev/null <<'EOF'
PermitRootLogin no
PasswordAuthentication no
EOF
sudo systemctl restart sshd
echo "  Root login and password auth disabled"

echo "[3/3] Installing and enabling Fail2Ban..."
if command -v yum &>/dev/null; then
  sudo yum install -y epel-release fail2ban
elif command -v apt-get &>/dev/null; then
  sudo apt-get install -y fail2ban
fi
sudo systemctl enable --now fail2ban
echo "  Fail2Ban enabled"

echo ""
echo "Setup complete. Test both keys before closing this session:"
echo "  ssh -i ~/.ssh/id_rsa_key1 ec2-user@<EC2-PUBLIC-IP>"
echo "  ssh -i ~/.ssh/id_rsa_key2 ec2-user@<EC2-PUBLIC-IP>"
