# Remove any old docker installations
apt-get remove -y docker docker-engine docker.io containerd runc
apt-get update -y
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Offical Docker GPG Key (Helps verify genuine software)
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |
  gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg

# Get codename of equivalent Ubuntu Linux Distribution so we can specify the right source
# for docker
UBUNTU_CODENAME=$( \
   (grep DISTRIB_CODENAME /etc/upstream-release/lsb-release || \
    grep DISTRIB_CODENAME /etc/lsb-release) 2>/dev/null | \
   cut -d'=' -f2 )

# Add the docker repository as a source that we can install from
cat <<EOF > /etc/apt/sources.list.d/docker.list
deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu ${UBUNTU_CODENAME} stable
EOF

# Update our package lists and install docker packages
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

# Install docker-compose, for convenience.
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose