ssh-copy-id -i ~/.ssh/id_rsa fmaced1@192.168.15.15
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt-get install -y \
        virtualbox \
        vagrant \
        git \
        vim \
        ansible