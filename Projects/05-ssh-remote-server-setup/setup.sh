#!/bin/bash
set -euo pipefail

# Usage examples:
#   # Copy keys to the server first, then run:
#   scp ~/.ssh/id_ed25519_key1.pub ~/.ssh/id_ed25519_key2.pub ec2-user@<EC2-PUBLIC-IP>:~/
#   ssh -i <key.pem> ec2-user@<EC2-PUBLIC-IP> 'bash setup.sh id_ed25519_key1.pub id_ed25519_key2.pub'
#
#   # Or pipe directly (keys must already be on the server):
#   ssh -i <key.pem> ec2-user@<EC2-PUBLIC-IP> 'bash -s id_ed25519_key1.pub id_ed25519_key2.pub' < setup.sh

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

# Amazon Linux uses 'sshd'; Ubuntu uses 'ssh'
if systemctl is-active --quiet sshd 2>/dev/null; then
  sudo systemctl restart sshd
else
  sudo systemctl restart ssh
fi
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
echo "  ssh -i ~/.ssh/id_ed25519_key1 ec2-user@<EC2-PUBLIC-IP>"
echo "  ssh -i ~/.ssh/id_ed25519_key2 ec2-user@<EC2-PUBLIC-IP>"
