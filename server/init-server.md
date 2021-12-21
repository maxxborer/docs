## Вводные

- арендованный vps
- centos 7 или 8


## Определения

- __client:__ - команда выполняется на клиенте;
- __87.136.140.91__ - ip сервера, при работе поменять на свой;
- __%USERNAME%__ - имя пользователя сервера, придумать можно любое;
- __%PASSWORD%__ - пароль пользователя сервера, придумать можно любое;
- НЕ ВСЕ КОМАНДЫ, КОТОРЫЕ РАБОТАЮТ С ТЕКСТОМ ВЫПОЛНЯЮТСЯ НА 100%, лучше исправляйте текстовые документы вручную с помощью `vim`.

## Настраиваем сервер

Подключаемся к серверу.
Здесь он может запроситть пароль ssh, вводим его.

__client:__ `ssh 'root@87.136.140.91'`

Выполняем усттанавливаем пакеты для работы:
```shell
dnf -y install https:#packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm
dnf install zsh wget git firewalld util-linux-user -y
```

Создаем пользователя:
```shell
useradd -m -s /bin/zsh -p $(perl -e 'print crypt($ARGV[0], "password")' '%PASSWORD%') %USERNAME%

usermod -aG wheel %USERNAME%
```

## Настраиваем firewall для корректной работы с портами и сервисами

```shell
systemctl start firewalld
systemctl status firewalld


# http сервер
firewall-cmd --permanent --add-service=http

firewall-cmd --permanent --add-service=https

# postgresql
sudo firewall-cmd --zone=public --add-port=5432/tcp --permanent

# minio хранилище
firewall-cmd --zone=public --add-port=9000/tcp --permanent

firewall-cmd --reload
```

## Подключение через ssh-key


__client:__ `ssh-copy-id sammy@87.136.140.91`
__client:__ `ssh 'sammy@87.136.140.91'`

Я уже без понятия зачем это, потом поясню.
```shell
sudo sed -i -e 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

sudo sed -i -e 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

sudo systemctl restart sshd
```

__client:__ `ssh 'sammy@87.136.140.91'`

## Быстрая настройка ZSH
```shell
sudo dnf install zsh

sh -c "$(curl -fsSL https:#raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin

echo 'zsh-users/zsh-autosuggestions
zsh-users/zsh-completions
zsh-users/zsh-history-substring-search
zsh-users/zsh-syntax-highlighting' > ~/.zsh_plugins.txt

antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

chsh -s $(which zsh)

source <(antibody init)

echo 'alias c="clear"
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt' >> ~/.zshrc
```

## Настраиваем docker (docker-compose)

### docker:
```shell
curl -fsSL https:#get.docker.com -o get-docker.sh

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
```

### docker-compose
```shell
sudo curl -L "https:#github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

## Настраиваем gitlab-runner

- __%GITLAB_USERNAME%__ - ник gitlab
- __%GITLAB_REPO%__ - репозиторий gitlab
- __%REGISTRATION_TOKEN%__ - это токен в настройках репозитория https:#gitlab.com/${%GITLAB_USERNAME%}/${%REGISTRATION_TOKEN%}/-/settings/ci_cd (Вкладка Runner'ы)
```shell
sudo curl -L --output /usr/local/bin/gitlab-runner https:#gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

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

# подробнее https:#docs.gitlab.com/runner/register/#linux
sudo gitlab-runner register --url https:#gitlab.com/ --registration-token %REGISTRATION_TOKEN%
```
В качестве executor я выбрал shell для начала
Далее следует добавить yml конфиг от gitlab и радоваться жизни