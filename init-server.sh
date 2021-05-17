# centos 7
# Настраиваем сервер, docker, gitlab runner для gitlab ci
# Подпись "CLIENT:" обозначает выполнение команды в shell клиента, а не на сервере
# Предполагается, что вы уже взяли в аренду сервер
# "78.140.136.90" - это ip ссервера, следует поменять на ip вашего сервера
# "sammy" - это имя пользователя, можно придумать любое
# НЕ ВСЕ КОМАНДЫ, КОТОРЫЕ РАБОТАЮТ С ТЕКСТОМ ВЫПОЛНЯЮТСЯ НА 100%, лучше исправляйте текстовые документы вручную с помощью vi

CLIENT: ssh 'root@78.140.136.90'

yum -y install https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm
yum install zsh wget git firewalld -y
useradd -m -s /bin/zsh -p $(perl -e 'print crypt($ARGV[0], "password")' 'ПРИДУМАЙТЕ И ВВЕДИТЕ СЮДА ПАРОЛЬ ДЛЯ ВАШЕГО НОВОГО ПОЛЬЗОВАТЕЛЯ') sammy
usermod -aG wheel sammy

systemctl start firewalld
systemctl status firewalld
firewall-cmd --permanent --list-all
firewall-cmd --get-services
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

CLIENT: ssh-copy-id sammy@78.140.136.90
CLIENT: ssh 'sammy@78.140.136.90'

sudo sed -i -e 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sudo sed -i -e 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

CLIENT: ssh 'sammy@78.140.136.90'

# КОМАНДЫ НИЖЕ НЕОБЯЗАТЕЛЬНЫЕ, ЗДЕСЬ Я НАСТРАИВАЮ SHELL
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin
echo 'zsh-users/zsh-autosuggestions
zsh-users/zsh-completions
zsh-users/zsh-history-substring-search
zsh-users/zsh-syntax-highlighting' > ~/.zsh_plugins.txt
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
# добавьте ZSHRC на ваш вкус
source ~/.zshrc
# ЗДЕСЬ Я ЗАКОНЧИЛ НАСТРОЙКУ SHELL

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo sh -eux <<EOF
# Set user.max_user_namespaces
cat <<EOT > /etc/sysctl.d/51-rootless.conf
user.max_user_namespaces = 28633
EOT
sysctl --system
EOF

sudo usermod -aG docker $USER
newgrp docker 
sudo systemctl enable docker
sudo systemctl enable containerd
sudo systemctl start docker
sudo systemctl start containerd
docker run hello-world

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Download the binary for your system
sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
# Give it permissions to execute
sudo chmod +x /usr/local/bin/gitlab-runner
# Create a GitLab CI user
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
sudo echo "gitlab-runner ALL=(ALL) NOPASSWD:ALL" > sudo /etc/sudoers
sudo usermod -aG docker gitlab-runner
newgrp docker gitlab-runner
sudo ln -s /usr/local/bin/gitlab-runner /usr/bin/gitlab-runner
# Install and run as service
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start
# подробнее https://docs.gitlab.com/runner/register/#linux
sudo gitlab-runner register --url https://gitlab.com/ --registration-token $REGISTRATION_TOKEN
# "$REGISTRATION_TOKEN" - это токен в настройках репозитория https://gitlab.com/${ВАШ_НИК_В_GITLAB}/${ВАШ_РЕПОЗИТОРИЙ}/-/settings/ci_cd (Вкладка Runner'ы)
# В качестве executor я выбрал shell для начала
# Далее следует добавить yml конфиг от gitlab и радоваться жизни

