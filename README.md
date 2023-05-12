docker build -t mikci:latest .

docker run -p 80:80 -p 3306:3306 -d mikci

docker run -p 5500:80 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=mikci -e MYSQL_USER=root -e MYSQL_PASSWORD= -d mikci
