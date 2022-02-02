## Вводные

- арендованный vps
- ubuntu 20.4

## Настраиваем сервер

Производим настройку по статье в DO: https://www.google.com/amp/s/www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-20-04-ru.amp

Устанавливаем docker согласно документации: https://docs.docker.com/engine/install/ubuntu/

Открываем порты в firewall: __TCP 22, TCP 80, TCP 443, TCP 2375, TCP 2376, TCP 2377, TCP 3000, TCP 7946, UDP 4789, UDP 7946__.

```shell
sudo ufw allow 22/tcp;
sudo ufw allow 80/tcp;
sudo ufw allow 443/tcp;
sudo ufw allow 2375/tcp;
sudo ufw allow 2376/tcp;
sudo ufw allow 2377/tcp;
sudo ufw allow 2511/tcp;
sudo ufw allow 3000/tcp;
sudo ufw allow 7946/tcp;
sudo ufw allow 4789/udp;
sudo ufw allow 7946/udp;
```

## Быстрая настройка ZSH
```shell
sudo apt zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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

## Настраиваем gitlab-runner

Создаём volume для конфига gitlab-runner:
```bash
docker volume create gitlab-runner-config
```

Запускаем gitlab-runner через docker:
```bash
docker run -d --name gitlab-runner --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v gitlab-runner-config:/etc/gitlab-runner \
    gitlab/gitlab-runner:alpine
```

Регистрируем runner:
```bash
docker run --rm -it -v gitlab-runner-config:/etc/gitlab-runner gitlab/gitlab-runner:alpine register
```
(https://docs.gitlab.com/runner/register/index.html#docker).

- Не забудьте указать ваши __tags__ при регистрации! И использовать эти теги в `gitlab.ci.yml` ваших проектов.
- Установите runner executor __'docker'__.
- В вашем vps авторизуйтесь как root:
```shell
sudo su
```
- Отредактируйте конфиг gitlab runner:
```shell
nano /var/lib/docker/volumes/gitlab-runner-config/_data/config.toml
```
- Вы должны поправить 2 строчки:
```toml
     privileged = true
     volumes = ["/cache", "/var/run/docker.sock:/var/run/docker.sock"]
```
- Чтобы конфиг выглядел примерно так:
```toml
concurrent = 1
check_interval = 0

[session_server]
   session_timeout = 1800

[[runners]]
   name = "maxxborer.com"
   url = "https://gitlab.com/"
   token = "{{YOUR_TOKEN}}"
   executor = "docker"
   [runners.custom_build_dir]
   [runners.cache]
     [runners.cache.s3]
     [runners.cache.gcs]
     [runners.cache.azure]
   [runners.docker]
     tls_verify = false
     image = "docker:stable"
     privileged = true
     disable_entrypoint_overwrite = false
     oom_kill_disable = false
     disable_cache = false
     volumes = ["/cache", "/var/run/docker.sock:/var/run/docker.sock"]
     shm_size = 0
```

Готово! Собирайте и деплойте ваши проекты!
