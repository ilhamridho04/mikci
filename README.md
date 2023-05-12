docker build -t mikci:latest .

docker run -p 5500:80 -p 3306:3306 -e DB_NAME=mikci -e DB_USER=root -e DB_PASSWORD=mikci123 -e PMA_ARBITRARY=1 -e PMA_HOST=localhost -e PMA_USER=root -e PMA_PASSWORD=mikci123 -d mikci
