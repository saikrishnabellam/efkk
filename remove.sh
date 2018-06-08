docker ps -a | awk '{ print $1,$2 }' | grep efk_* | awk '{print $1 }' | xargs -I {} docker stop {}
docker ps -a | awk '{ print $1,$2 }' | grep efk_* | awk '{print $1 }' | xargs -I {} docker rm {}
docker ps -a | awk '{ print $1,$2 }' | grep fluent* | awk '{print $1 }' | xargs -I {} docker stop {}
docker ps -a | awk '{ print $1,$2 }' | grep fluent* | awk '{print $1 }' | xargs -I {} docker rm {}
docker volume rm $(docker volume ls)
docker-compose down -v
