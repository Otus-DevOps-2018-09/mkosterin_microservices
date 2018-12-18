#!/bin/bash
#docker kill $(docker ps -q)
#docker network create reddit
echo "1-mongo"
docker run -d --network=back_net --network-alias=post_db --network-alias=comment_db mongo:latest
echo "2-post"
docker run -d --network=back_net --name post mkosterin/post:1.0
echo "3-comment"
docker run -d --network=back_net --name comment mkosterin/comment:2.0
echo "4-ui"
docker run -d --network=front_net -p 9292:9292 --name ui mkosterin/ui:2.0

docker network connect front_net post
docker network connect front_net comment

