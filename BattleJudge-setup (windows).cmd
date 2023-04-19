docker pull battlejudge/battlejudgeapi:latest
docker pull mariadb:latest
docker pull battlejudge/battlejudgewebapp:latest
docker network create bjnet
docker rm BattleJudgeAPI BattleJudgeDB BattleJudgeWebApp
docker run -d -e MARIADB_ROOT_PASSWORD=root -p 3306:3306 --network bjnet --network-alias bjdb --name BattleJudgeDB mariadb
timeout 5
docker run -d -e DB_HOST=jdbc:mysql://bjdb:3306 -e DB_USER=root -e DB_PASSWORD=root -p 9000:9000 --network bjnet --network-alias bjapi --name BattleJudgeAPI battlejudge/battlejudgeapi:latest
timeout 5
docker run -d -e API_URL=http://bjapi:9000/ -p 8080:8080 --network bjnet --name BattleJudgeWebApp battlejudge/battlejudgewebapp:latest