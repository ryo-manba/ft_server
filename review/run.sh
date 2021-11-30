#!/bin/bash
docker run --name ft_server -d -p 8080:80 -p 443:443 ft_server

# AutoIndex off
# docker run --name off -d -p 8080:80 -p 443:443 -e AUTOINDEX=off ft_server
