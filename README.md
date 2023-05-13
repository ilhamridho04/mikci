docker build -t mikci:latest .

docker run -p 80:80 -p 3306:3306 -d mikci

docker run -p 5500:80 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=mikci -e MYSQL_USER=root -e MYSQL_PASSWORD= -d mikci


docker run -d -p 80:80 -p 3306:3306 --name mikci-app mikci


docker run -d -p 8001:8000 -p 9000:9000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
