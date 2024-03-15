#!/bin/bash
echo 'hello, we are starting to install software'

# Перечитываем пакеты и обновляем ОС
export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get dist-upgrade -y

# Устнавливаем terraform и terragrunt с учетом яндекс-зеркала для работы в условиях блокировок - делаем исполняемыми бинарные файлы'
chmod +x /home/ubuntu/terraform
chmod +x /home/ubuntu/terragrunt
mv /home/ubuntu/terraform /bin/terraform
mv /home/ubuntu/terragrunt /bin/terragrunt
cp /home/ubuntu/.terraformrc /root/.terraformrc

# Ставим предварительные пакеты и зависимости для дальнейших установок утилит, ставим git и синхронизируем время на сервисной ноде'
apt-get install -y git curl ca-certificates gnupg lsb-release gnome-terminal apt-transport-https gnupg-agent software-properties-common chrony tzdata
timedatectl set-timezone Europe/Moscow && systemctl start chrony && systemctl enable chrony

# Ставим docker
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
systemctl enable docker.service && systemctl enable containerd.service && systemctl start docker.service && sudo systemctl start containerd.service

# Ставим jq, pip и ansible
add-apt-repository ppa:deadsnakes/ppa -y
apt install python3-pip -y
apt-get install jq ansible -y

# Установка kubeadm kubectl
# Ставим публичный ключ Google Cloud.
# Добавляем Kubernetes репозиторий и перечитываем их:
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update

# Устанавливаем и замораживаем версию утилит при последующих обновлениях через пакетный менеджер:
apt-get install -y kubeadm kubectl
apt-mark hold kubeadm kubectl

# Установка helm
# Ставим ключ и репозиторий:
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

# Перечитываем репозитории и ставим helm
apt-get update
apt-get install helm -y

# Установка gitlab-runner
# Ставим официальный репозиторий gitlab-runner и перечитываем списки репозиторий
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
apt-get update

# Установка и запуск gitlab-runner
apt-get install gitlab-runner -y
systemctl enable gitlab-runner --now
