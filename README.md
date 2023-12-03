# Docker PHP Devbox

> Minimalist Docker PHP environment using PHP 8.2 and Symfony 6.4 LTS

## Summary

- Dockerfile & Docker-compose setup with PHP 8.2, Postgresql 
- Default Symfony 6.4 installation with a /healthz endpoint and a test for it. Another framework could be used as long
  as the entry point is in public/index.php
- After the image is started the app should run on port 9001 on localhost. You can try the existing
  endpoint: http://localhost:9001/healthz
- The default database is very creatively called `database` and the username and password are `devbox` & `devbox`
  respectively
- The Postgresql database can be accessed using port 5431 on localhost

## Debugging

- Debugging can be enabled by uncommenting the contents of the file ./docker/service/xdebug.ini
- When configuring debugging in PHPStorm:
    - Choose `PHP Remote Debugging` as CLI interpreter. Make sure local interpreter is removed
    - Choose `Docker Compose` as the configuration type and `devbox-service` as the service
    - Lifecycle should be `Connect to existing container`

## Installation

```
  make run && make install
```

## Run tests

```
  make test
```

The setup was tested using Ubuntu 22.04.
