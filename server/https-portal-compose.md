```yaml
version: "3.7"

services:
  reverse-proxy:
    image: "nginxproxy/nginx-proxy:latest"
    container_name: "reverse-proxy"
    volumes:
      - "html:/usr/share/nginx/html"
      - "vhost:/etc/nginx/vhost.d"
      - "certs:/etc/nginx/certs:ro"
      - "/var/run/docker.sock:/tmp/docker.sock:ro"
    restart: "always"
    networks: 
      - "***REMOVED***-network"
    ports:
      - "80:80"
      - "443:443"

  nginx-proxy-acme:
    image: "nginxproxy/acme-companion:latest"
    container_name: "nginx-proxy-acme"
    environment:
      NGINX_PROXY_CONTAINER: "reverse-proxy"
      DEFAULT_EMAIL: "***REMOVED***@gmail.com"
    restart: "always"
    volumes:
      - "html:/usr/share/nginx/html"
      - "vhost:/etc/nginx/vhost.d"
      - "certs:/etc/nginx/certs:rw"
      - "/var/run/docker.sock:/var/run/docker.sock:ro"
      - "acme:/etc/acme.sh"
    depends_on:
      - "reverse-proxy"
    networks: 
      - "***REMOVED***-network"

volumes:
  conf:
  vhost:
  certs:
  acme:
  html:

networks:
  ***REMOVED***-network:
    external: true
```
