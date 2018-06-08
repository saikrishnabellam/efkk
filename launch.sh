docker-compose up -d --build
sleep 1m
docker exec elasticsearch /usr/share/elasticsearch/bin/init_sg.sh
sleep 30s
cd ./fluentd/
docker-compose up -d --build
docker start nginx-gen1
docker start nginx-gen2
docker start nginx-gen3
