ssh-copy-id -i ~/.ssh/id_rsa fmaced1@192.168.15.15
sudo ufw disable
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common \
        virtualbox \
        vagrant \
        git \
        vim \
        ansible \
        docker.io \
        kubectl

sudo usermod -aG docker $USER
sudo systemctl daemon-reload
sudo systemctl restart docker