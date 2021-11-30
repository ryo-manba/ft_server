# ft_server

## Description

In this project, we will install a complete web server using the "Docker" technology.

## Features

The Docker image would include:

- Nginx
- PHP
- MariaDB SQL database
- PhpMyAdmin
- Wordpress

## Usage

```
git clone ...
cd ft_server

# build image
docker build -t <img_name> .

# run container 
docker run --name <container_name> -d -p 8080:80 -p 443:443 <img_name>

# enter container's interactive mode
docker exec -it <container_name> bash

# stop and remove container
docker stop <container_name> && docker rm <container_name>

# remove image
docekr rmi <image_name>
```
## Author

[twitter](https://twitter.com/ryo_manba)

## Licence

All code is released under the [MIT](https://github.com/ryo-manba/ft_server/blob/main/LICENSE) license
